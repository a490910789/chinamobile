<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>系统管理--操作员管理</title>
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
      <label class="layui-form-label">操作员名称</label>
      <div class="layui-input-inline">
        <input type="text" name="name" id="name"   autocomplete="off" class="layui-input">
      </div>
      <label class="layui-form-label">登入名</label>
      <div class="layui-input-inline">
        <input type="text" name="loginname"  id="loginname" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
       <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
       <button type="reset" class="layui-btn layui-btn-warm">重置</button>
   </div>
 </form>
	<table id="operatorList" lay-filter="operatorList"></table>
	<!-- 表格工具条 批量删除-->
<script type="text/html" id="tableToolBar">
	    <a class="layui-btn layui-btn-sm" lay-event="add">添加</a>
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel">批量删除</a> 
</script>

	<!-- 操作 -->
	<script type="text/html" id="operatorListBar">
		<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update">修改</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
		<a class="layui-btn layui-btn-xs layui-btn" lay-event="resetPwd">重置密码</a>
	</script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
var tableIns;
//根据id搜索
function reloadTable(id){
	tableIns.reload({
        page: {
            curr: 1 //重新从第 1 页开始
        },
        where: {
            name: $("#name").val(),  //搜索的关键字
            loginname: $("#loginname").val(),  //搜索的关键字
       }
   });
}

layui.use(['form','layer','laydate','table','laytpl'],function(){
        var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;
        
    //登入操作员列表
        tableIns = table.render({
        elem: '#operatorList',
        url : '${ctx }/operator/queryAllOperator.action',
        cellMinWidth : 95,
        toolbar: '#tableToolBar',
        page : true,
        height : "full-180",
        limit : 10,
        limits : [10,15,20,25],
        defaultToolbar: ['filter'],
        id : "operatorListTable",
        cols : [[
        	{type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID',align:"center"},
            {field: 'name', title: '操作员姓名', align:"center"},
            {field: 'loginname', title: '登陆名称', align:"center"},
            {field: 'pwd', title: '密码',align:"center",templet:function(data){
            	return "******";
            }},
            {field: 'type', title: '角色', align:'center',templet:function(data){
            	return data.type==1?"<font color=green>操作员</font>":"<font color=red>超级管理员</font>"
            }},
            {title: '操作', width:200, templet:'#operatorListBar',fixed:"right",align:"center"}
        ]]
    });
    
      //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn").on("click",function(){
        	  reloadTable(null);
        });

       //监听按钮
    table.on('toolbar(operatorList)', function(obj){
    	switch (obj.event) {
		case "add":
			toAdd();
			break;
		case "batchDel":
			batchDel();
			break;
		default:
			break;
    	}
    }); 
  
    //监听按钮
    table.on('tool(operatorList)', function(obj){
    	var id=obj.data.id;
    	switch (obj.event) {
		case "delete":
			deleteOperator(id);
			break;
		case "update":
			updateOperator(id);
			break;
		case "resetPwd":
			resetPwd(obj);
			break;
		case "setRoles":
			setRoles(id);
			break;
    	}
    });
    
    //添加操作员
    function toAdd(){
			layer.open({
				title:['添加操作员'],  
				type:2,
				content:'${ctx}/operator/toAddOperator.action',
				area:['800px','550px'],
				maxmin:true,
				success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回操作员列表', '.layui-layer-setwin .layui-layer-close', {
	                        tips: 3
	                    });
	                },500)
	            }
			});
       }
    //修改
    function updateOperator(id){
    	layer.open({
			title:['修改操作员'],  
			type:2,
			content:'${ctx}/operator/toUpdateOperator.action?id='+id,
			area:['800px','550px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回操作员列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    //分配权限
    function setRoles(id){
    	layer.open({
			title:['分配权限'],  
			type:2,
			content:'${ctx}/operator/toSetRoles.action?id='+id,
			area:['800px','380px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回操作员列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    //删除单个
    function deleteOperator(id){
    	 layer.confirm('确定删除选中的操作员？', {icon: 3, title: '提示信息'}, function (index) {
   		  $.post("${ctx}/operator/delOperator.action?id="+id,function(result){
   	          	layer.msg(result.msg);
   	          });
             tableIns.reload();
        });
     }
    
    //批量删除
    function batchDel(){
        var checkStatus = table.checkStatus('operatorListTable'),
            data = checkStatus.data,
            url="${ctx}/operator/delOperators.action?1=1";
        if(data.length > 0) {
            for (var i in data) {
                url+="&ids="+data[i].id;
            }
            layer.confirm('确定删除选中的操作员？', {icon: 3, title: '提示信息'}, function (index) {
                $.post(url,function(result){
                	layer.msg(result.msg);
                });
                tableIns.reload();
            });
        }else{
            layer.msg("请选择需要删除的操作员");
        }
    }
    
    //重置密码
   function resetPwd(obj){
	   layer.confirm("确定重置操作员【"+obj.data.name+"】的密码吗？", {icon: 3, title: '提示信息'}, function (index) {
	   		  $.post("${ctx}/operator/resetPwd.action?id="+obj.data.id,function(result){
	   	          	layer.msg(result.msg);
	   	          });
	             tableIns.reload();
	        });
        }
});

</script>
</body>
</html>