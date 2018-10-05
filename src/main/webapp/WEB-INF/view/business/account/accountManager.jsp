<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>号码账户管理</title>
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
   <div class="layui-form-item layui-inline">
      <label class="layui-form-label">账户ID</label>
      <div class="layui-input-inline">
        <input type="text" name="aid"  id="aid" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
       <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
       <button type="reset" class="layui-btn layui-btn-warm">重置</button>
   </div>
 </form>
	<table id="accountList" lay-filter="accountList"></table>
	<!-- 表格工具条 批量删除-->
<script type="text/html" id="tableToolBar">
	    <a class="layui-btn layui-btn-sm" lay-event="add">添加</a>
</script>

	<!-- 操作 -->
	<script type="text/html" id="accountListBar">
		<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update">充值</a>
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
        	aid: $("#aid").val()
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
        
    //账户列表
        tableIns = table.render({
        elem: '#accountList',
        url : '${ctx }/account/queryAllAccount.action',
        cellMinWidth : 95,
        toolbar: '#tableToolBar',
        page : true,
        height : "full-180",
        limit : 10,
        limits : [10,15,20,25],
        defaultToolbar: ['filter'],
        id : "accountListTable",
        cols : [[
            {field: 'aid', title: '账户ID',align:"center"},
            {field: 'person', title: '账户人',align:"center"},
            {field: 'address', title: '住址', align:"center"},
            {field: 'balance', title: '账户余额', align:"center"},
            {title: '操作', width:150, templet:'#accountListBar',fixed:"right",align:"center"}
        ]]
    });
    
      //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn").on("click",function(){
        	  reloadTable();
        });

       //监听按钮
    table.on('toolbar(accountList)', function(obj){
    	switch (obj.event) {
		case "add":
			toAdd();
			break;
    	}
    }); 
  
    //监听按钮
    table.on('tool(accountList)', function(obj){
    	var id=obj.data.aid;
    	switch (obj.event) {
		case "delete":
			deleteAccount(id);
			break;
		case "update":
			updateAccount(id);
			break;
    	}
    });
    
    //添加账户
    function toAdd(){
			layer.open({
				title:['添加账户'],  
				type:2,
				content:'${ctx}/account/toAddAccount.action',
				area:['400px','400px'],
				maxmin:true,
				success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回账户列表', '.layui-layer-setwin .layui-layer-close', {
	                        tips: 3
	                    });
	                },500)
	            }
			});
       }
    //修改
    function updateAccount(id){
    	layer.open({
			title:['修改账户'],  
			type:2,
			content:'${ctx}/account/toUpdateAccount.action?aid='+id,
			area:['800px','550px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回账户列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    
    //删除单个
    function deleteAccount(id){
    	 layer.confirm('确定删除选中的账户？', {icon: 3, title: '提示信息'}, function (index) {
   		  $.post("${ctx}/account/deleteAccount.action?aid="+id,function(result){
   	          	layer.msg(result.msg);
                tableIns.reload();
   	        });
        });
     }
     
});
</script>
</body>
</html>