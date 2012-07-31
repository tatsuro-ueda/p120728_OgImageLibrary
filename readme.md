## Sample project to get og:image


The probrem was already solved. The reason of error is mis-handling of character encoding.

Codes below handle the character encoding of HTML and return og:image URL.

	- (NSURL *)ogImageURLWithURL:(NSURL *)url
	{
		NSString *string = [self encodedStringWithContentsOfURL:url];    
	    
	    // prepare regular expression to find text
	    NSError *error   = nil;
	    NSRegularExpression *regexp =
	    [NSRegularExpression regularExpressionWithPattern:
	     @"<meta property=\"og:image\" content=\".+\""
	                                              options:0
	                                                error:&error];
	    
	    // find by regular expression
	    NSTextCheckingResult *match =
	    [regexp firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
	    
	    // get the first result
	    NSRange resultRange = [match rangeAtIndex:0];
	    NSLog(@"match=%@", [string substringWithRange:resultRange]); 
	    
	    if (match) {
	        
	        // get the og:image URL from the find result
	        NSRange urlRange = NSMakeRange(resultRange.location + 35, resultRange.length - 35 - 1);
	        NSURL *urlOgImage = [NSURL URLWithString:[string substringWithRange:urlRange]];
	        return urlOgImage;
	    }
	    return nil;
	}
	
    - (NSString *)encodedStringWithContentsOfURL:
        (NSURL *)url
    {
        // Get the web page HTML
        NSData *data = [NSData dataWithContentsOfURL:url];
        
	    // response
	    int enc_arr[] = {
		    NSUTF8StringEncoding,			// UTF-8
		    NSShiftJISStringEncoding,		// Shift_JIS
		    NSJapaneseEUCStringEncoding,	// EUC-JP
		    NSISO2022JPStringEncoding,		// JIS
		    NSUnicodeStringEncoding,		// Unicode
		    NSASCIIStringEncoding			// ASCII
    	};
	    NSString *data_str = nil;
	    int max = sizeof(enc_arr) / sizeof(enc_arr[0]);
	    for (int i=0; i<max; i++) {
		    data_str = [
                [NSString alloc]
                initWithData : data
                encoding : enc_arr[i]
                ];
		    if (data_str!=nil) {
			    break;
		    }
	    }
	    return data_str;    
    }

-----

## Problem

The first sample is success case.

The URL is <http://www.nicovideo.jp/watch/1343369790>

![Screen Shot](http://farm8.staticflickr.com/7118/7660481312_c8997f74a7_o.png)

The second sample is failure case.

The URL is <http://business.nikkeibp.co.jp/article/NBD/20120727/235043/?ST=pc>

This case returns exception when evaluating 'match' valiable.

![Screen Shot](http://farm9.staticflickr.com/8152/7660481154_69e37e049b_o.png)