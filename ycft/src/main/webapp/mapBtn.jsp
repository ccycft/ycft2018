<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<title>Insert title here</title>
  	<link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="./assets/bootstrap/js/bootstrap.min.js"></script>
  
   <script>
  
    
     $(function(){
    	 
    	 $(".col-xs-2").click(function(event){
    		 var mark = $(event.target).attr("id")||$(event.target).parent().attr('id');
    		 console.log(mark);

				$.ajax({
    			  type: 'POST',
    			  url: '',
    			  async:false,
    			  data: mark,
    			  success: function(eve,xhr){
    				  var value = xhr.responseText;
    			  },
    			  dataType: 'text'
    			});
    		 
    		 
    		 /*
    		  mark = parseInt(mark);
    		  switch(mark){
    			case 1:
    				window.open('http://uri.amap.com/marker?markers=125.286283,43.824238,报道点A|125.286304,43.824632,报到点B|125.286315,43.82375,报道点C','map');
    				break;
    			case 2:
    				window.open('http://uri.amap.com/marker?markers=125.27527,43.822718,运动场|125.27571,43.824026,篮球场|125.275152,43.823716,排球场','map');
    				break;
    			case 3:
    				window.open('http://uri.amap.com/marker?markers=125.286283,43.824238,报道点A|125.286304,43.824632,报到点B|125.286315,43.82375,报道点C','map');
    				break; 
    			default:
    				break;
    		 }  */
    	 });
     });
    </script>
    
    
</head>
<style>
	.container-fluid{
		position:absolute;
		bottom:0px;
		left:0px;
	}
	.col-xs-2{
	
		margin-top:1.0rem;
		margin-left:2.5rem;	
	}
	span{
		line-height:3rem;
		font-size:1rem;
	}
	
</style>
<body class="text-center">
	
	
</body>
</html>