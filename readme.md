## Sample project to get og:image


The probrem was already solved. The reason of error is mis-handling of character encoding.

-----

The first sample is success case.

The URL is <http://www.nicovideo.jp/watch/1343369790>

![Screen Shot](http://farm8.staticflickr.com/7118/7660481312_c8997f74a7_o.png)

The second sample is failure case.

The URL is <http://business.nikkeibp.co.jp/article/NBD/20120727/235043/?ST=pc>

This case returns exception when evaluating 'match' valiable.

![Screen Shot](http://farm9.staticflickr.com/8152/7660481154_69e37e049b_o.png)