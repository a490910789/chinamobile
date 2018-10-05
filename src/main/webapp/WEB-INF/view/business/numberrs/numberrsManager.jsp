<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>号码资源管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
  <legend>查询条件</legend>
</fieldset>
<form class="layui-form" id="fm" >
   <input type="hidden" name="available" id="available"> 
   <div class="layui-form-item layui-inline">
      <label class="layui-form-label">手机号码</label>
      <div class="layui-input-inline">
        <input type="text" name="phonenumber"  id="phonenumber" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item layui-inline">
      <label class="layui-form-label">号码类型</label>
      <div class="layui-input-inline">
        <input type="text" name="phonetype"  id="phonetype" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
       <a href="javascript:void(0)" class="search_btn1 layui-btn">查询</a>
       <a href="javascript:void(0)" class="search_btn2 layui-btn layui-btn-normal">查询可用</a>
       <button type="reset" class="layui-btn layui-btn-warm">重置</button>
   </div>
 </form>
	<table id="numberrsList" lay-filter="numberrsList"></table>
	<!-- 表格工具条 批量删除-->
<script type="text/html" id="tableToolBar">
	    <a class="layui-btn layui-btn-sm" lay-event="add">添加</a>
	    <a class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">从制定文件中导入</a>
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel">批量删除</a> 
</script>

	<!-- 操作 -->
	<script type="text/html" id="numberrsListBar">
		<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update">修改</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
	</script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
var tableIns;
//根据id搜索
function reloadTable(){
	tableIns.reload({
        page: {
            curr: 1 //重新从第 1 页开始
        },
        where: {
        	phonenumber: $("#phonenumber").val(),  //搜索的关键字
        	phonetype: $("#phonetype").val(),  //搜索的关键字
        	available: $("#available").val()
       }
   });
}

layui.use(['form','layer','laydate','table','laytpl'],function(){
        var form = layui.form,
        layer=layui.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;
        
    //资源列表
        tableIns = table.render({
        elem: '#numberrsList',
        url : '${ctx }/numberrs/queryAllNumberrs.action',
        cellMinWidth : 95,
        toolbar: '#tableToolBar',
        page : true,
        height : "full-180",
        limit : 10,
        limits : [10,15,20,25],
        defaultToolbar: ['filter'],
        id : "numberrsListTable",
        cols : [[
        	{type: "checkbox", fixed:"left", width:50},
            {field: 'phonenumber', title: '手机号码',align:"center"},
            {field: 'phonetype', title: '号码类型',align:"center"},
            {field: 'carnumber', title: '卡号', align:"center"},
            {field: 'available', title: '是否可用',align:"center",templet:function(data){
            	return data.available==1?"<font color=blue>可用</font>":"<font color=red>不可用</font>"
            }},
            {title: '操作', width:150, templet:'#numberrsListBar',fixed:"right",align:"center"}
        ]]
    });
    
      //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn1").on("click",function(){
        	  $("#available").val(null);
        	  reloadTable();
        });
        //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn2").on("click",function(){
        	$("#available").val(1);
        	  reloadTable();
        });

       //监听按钮
    table.on('toolbar(numberrsList)', function(obj){
    	switch (obj.event) {
		case "add":
			toAdd();
			break;
		case "batchDel":
			batchDel();
			break;
    	}
    }); 
  
    //监听按钮
    table.on('tool(numberrsList)', function(obj){
    	var id=obj.data.uid;
    	switch (obj.event) {
		case "delete":
			deleteNumberrs(id);
			break;
		case "update":
			updateNumberrs(id);
			break;
    	}
    });
    
    //添加资源
    function toAdd(){
			layer.open({
				title:['添加资源'],  
				type:2,
				content:'${ctx}/numberrs/toAddNumberrs.action',
				area:['400px','400px'],
				maxmin:true,
				success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回资源列表', '.layui-layer-setwin .layui-layer-close', {
	                        tips: 3
	                    });
	                },500)
	            }
			});
       }
    //修改
    function updateNumberrs(id){
    	layer.open({
			title:['修改资源'],  
			type:2,
			content:'${ctx}/numberrs/toUpdateNumberrs.action?uid='+id,
			area:['800px','550px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回资源列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    
    //删除单个
    function deleteNumberrs(id){
    	 layer.confirm('确定删除选中的资源？', {icon: 3, title: '提示信息'}, function (index) {
   		  $.post("${ctx}/numberrs/deleteNumberrs.action?uid="+id,function(result){
   	          	layer.msg(result.msg);
                tableIns.reload();
   	        });
        });
     }
    
    //批量删除
    function batchDel(){
        var checkStatus = table.checkStatus('numberrsListTable'),
            data = checkStatus.data,
            url="${ctx}/numberrs/deleteNumberrss.action?1=1";
        if(data.length > 0) {
            for (var i in data) {
                url+="&ids="+data[i].uid;
            }
            layer.confirm('确定删除选中的资源？', {icon: 3, title: '提示信息'}, function (index) {
                $.post(url,function(result){
                	layer.msg(result.msg);
                    tableIns.reload();
                });
            });
        }else{
            layer.msg("请选择需要删除的资源");
        }
    }
});
</script>
</body>
</html>