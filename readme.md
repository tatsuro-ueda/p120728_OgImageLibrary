## Objective-C Library to get og:image

### Usage

1. import library files: NSURL+OgImage.h/m
2. import library files: NSString+Encode.h/m
2. write code like below:

### Code

    NSData *d = [NSData dataWithContentsOfURL:[NSURL ogImageURLWithURL:url]];
    imageView.image = [UIImage imageWithData:d];

### Sample project

A project with one text field and one image view. When you enter the URL, the og:image of the web page will be shown.

For example, in the below screenshot, the URL is <http://www.nicovideo.jp/watch/1343369790>

![Screen Shot](http://farm8.staticflickr.com/7118/7660481312_c8997f74a7_o.png)