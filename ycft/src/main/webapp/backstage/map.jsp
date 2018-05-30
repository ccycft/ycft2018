<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>鼠标拾取地图坐标</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript"
            src="http://webapi.amap.com/maps?v=1.4.6&key=82a461d12ba64ec960f5fe838ccd10a5"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
</head>
<body>
<div id="container"></div>
<div id="myPageTop">
    <table>
        <tr>
            <td>
                <label>按关键字搜索：</label>
            </td>
        </tr>
        <tr>
            <td>
                <input type="text" placeholder="请输入关键字进行搜索" id="tipinput">
            </td>
        </tr>
    </table>
</div>
<div class="button-group">
    <input type="button" class="button" value="从多个点中删除指定点" id="clearMarker"/>
    <form action="" method="post">
	<input type="text" id="mapPosition" name="mapPosition"/>
	<input type="button" value="测试" onclick="clickMap()">
</form>
</div>
<script type="text/javascript">
    var map = new AMap.Map("container", {
       resizeEnable: true,
        center: [126.568923,43.924275],
        zoom: 16
    });
    //设置搜索联想与poi对接
    AMap.plugin(['AMap.Autocomplete','AMap.PlaceSearch'],function(){
	     var autoOptions = {
	          city: "", //城市，默认全国
	          input: "tipinput"//使用联想输入的input的id
	     };
	     autocomplete= new AMap.Autocomplete(autoOptions);
	     AMap.event.addListener(autocomplete, "select", function(e){
	           //TODO 针对选中的poi实现自己的功能
	           //placeSearch.search(e.poi.name);
	           map.setCenter(e.poi.location);
	     });
	});
    
    var contextMenu = new AMap.ContextMenu();  //创建右键菜单
	//用来存储标记点的信息
    var markers = [], positions = [];
    //地图绑定鼠标右击事件——弹出右键菜单	
    map.on('rightclick', function(e) {
        contextMenuPositon = e.lnglat;
    	console.log(e.lnglat+'');
         var marker = new AMap.Marker({
            map: map,
            position: contextMenuPositon //基点位置
        });
      markers.push(marker);
      positions.push(contextMenuPositon);
    });
    function createInput()
    {
    document.getElementById("test").innerHTML = "<input type='text'/>";
    }
    //删除所有标记的点 
   AMap.event.addDomListener(document.getElementById('clearMarker'), 'click', function() {
        map.remove(markers);
        //markers = null;
        for(var i = 0; i<markers.length;i++){
        	markers.remove(markers[i]);
        }
    }, false);
    //把地点的坐标存在隐藏域里
    function clickMap(){
    	var data  = "[";
    	for(var i = 0;i<markers.length;i++){
    		if(i == markers.length-1){
    			data = data + markers[i].getPosition()+"]";
    		}else{
    			data = data + markers[i].getPosition()+"],[";
    		}
    	}
    	document.getElementById("mapPosition").value = data;
    }
</script>
</body>
</html>