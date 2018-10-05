<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户管理</title>
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
      <label class="layui-form-label">手机号码</label>
      <div class="layui-input-inline">
        <input type="text" name="phone"  id="phone" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
       <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
       <button type="reset" class="layui-btn layui-btn-warm">重置</button>
   </div>
 </form>
	<table id="userList" lay-filter="userList"></table>
	<!-- 表格工具条 批量删除-->
<script type="text/html" id="tableToolBar">
	    <a class="layui-btn layui-btn-sm" lay-event="add">添加</a>
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel">批量删除</a> 
</script>

	<!-- 操作 -->
	<script type="text/html" id="userListBar">
		<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="update">修改</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
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
        	phone: $("#phone").val(),  //搜索的关键字
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
        
    //用户列表
        tableIns = table.render({
        elem: '#userList',
        url : '${ctx }/user/queryAllUser.action',
        cellMinWidth : 95,
        toolbar: '#tableToolBar',
        page : true,
        height : "full-180",
        limit : 10,
        limits : [10,15,20,25],
        defaultToolbar: ['filter'],
        id : "userListTable",
        cols : [[
        	{type: "checkbox", fixed:"left", width:50},
            {field: 'uid', title: 'ID',align:"center"},
            {field: 'cname', title: '用户姓名',align:"center"},
            {field: 'phone', title: '手机号码', align:"center"},
            {field: 'roaming', title: '漫游状态', align:'center',templet:function(data){
            	if(data.roaming=="p"){
            		return  "省内漫游";
            	}else if(data.roaming=="d"){
            		return "国内漫游";
            	}else{
            		return "国际漫游";
            	}
            }},
            {field: 'comLevel', title: '通话级别', align:'center',templet:function(data){
            	if(data.comLevel=="l"){
            		return  "本地通话";
            	}else if(data.roaming=="d"){
            		return "国内长途";
            	}else{
            		return "国际长途";
            	}
            }},
            {field: 'balance', title: '账户余额',align:"center"},
            {title: '操作', width:150, templet:'#userListBar',fixed:"right",align:"center"}
        ]]
    });
    
      //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn").on("click",function(){
        	  reloadTable(null);
        });

       //监听按钮
    table.on('toolbar(userList)', function(obj){
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
    table.on('tool(userList)', function(obj){
    	var id=obj.data.uid;
    	switch (obj.event) {
		case "delete":
			deleteUser(id);
			break;
		case "update":
			updateUser(id);
			break;
    	}
    });
    
    //添加用户
    function toAdd(){
			layer.open({
				title:['添加用户'],  
				type:2,
				content:'${ctx}/user/toAddUser.action',
				area:['400px','400px'],
				maxmin:true,
				success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
	                        tips: 3
	                    });
	                },500)
	            }
			});
       }
    //修改
    function updateUser(id){
    	layer.open({
			title:['修改用户'],  
			type:2,
			content:'${ctx}/user/toUpdateUser.action?uid='+id,
			area:['800px','550px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    
    //删除单个
    function deleteUser(id){
    	 layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
   		  $.post("${ctx}/user/deleteUser.action?uid="+id,function(result){
   	          	layer.msg(result.msg);
                tableIns.reload();
   	        });
        });
     }
    
    //批量删除
    function batchDel(){
        var checkStatus = table.checkStatus('userListTable'),
            data = checkStatus.data,
            url="${ctx}/user/deleteUsers.action?1=1";
        if(data.length > 0) {
            for (var i in data) {
                url+="&ids="+data[i].uid;
            }
            layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
                $.post(url,function(result){
                	layer.msg(result.msg);
                    tableIns.reload();
                });
            });
        }else{
            layer.msg("请选择需要删除的用户");
        }
    }
});
</script>
</body>
</html>