# PlayYoukuVideo
之前在项目中有个播放视频的功能，但是这些视频又不是放在服务器上面的。而是用户上传到优酷上面，然后将视频的信息地址等等保存在服务器，app端请求时数据返回到app端。

本来需求的要求也不是很高的，只要能到页面播放视屏就OK了。于是我就直接把一串地址加载到UIWebView上就完事了。。。效果是这样的：
不过这样的话，页面好像挺大的，网速慢的时候加载起来会有点慢，影响用户的体验。

不久，需求说这样太难看了，整个页面都显示出来了。能不能改一下，只是显示视频的缩略图。要的效果如下：


OK，as your wish，尝试一下。
上优酷的开发者平台(http://open.youku.com/tools) 一看，我擦，坑爹嘛连iOS SDK都没有的！！让我们敬请期待。。。没办法了，就试试web JS的方法了。上面有介绍：


我们要来看看这段代码：
<div id="youkuplayer" style="width:480px;height:400px"></div>
<script type="text/javascript" src="http://player.youku.com/jsapi">
player = new YKU.Player('youkuplayer',{
styleid: '0',
client_id: 'YOUR YOUKUOPENAPI CLIENT_ID',
vid: '替换成优酷视频ID'
});
</script>

首先，需要有：client_id－－优酷开放平台创建应用的client_id；你也可以设置styleid的类型；好了，接着，需要有vid: '优酷视频ID'；再接着解析你的视频URL地址，for example,(http://v.youku.com/v_show/id_XNDcwMDc3MTk2.html?from=y1.7-2) --拿到id_后面的那串东西。。。

OK，最后就是通过webview的方法 - (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL; 来加载上面那一大串替代后的JS代码。与此同时也设置一下上面JS里style的width和heigh以适配不同的机型。最后效果如下：
![](https://github.com/ljhang/PlayYoukuVideo/raw/master/video.gif) 

如果你发现有错误的地方、有不明白的地方、或者更好的改进的地方，欢迎指正，一起学习进步。或者在此留言给我，或者联系我：ljhang1@163.com thank you～～ 

