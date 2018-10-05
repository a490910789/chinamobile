<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>客户管理</title>
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
  <legend>客户信息</legend>
</fieldset>
	<table id="customerList" lay-filter="customerList"></table>
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
var tableForUser;
layui.use(['form','layer','table','laytpl'],function(){
        var form = layui.form,
        layer=layui.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;
        
    //登入客户列表
        tableIns = table.render({
        elem: '#customerList',
        url : '${ctx }/customer/queryCustomerByIdentity.action?identity=${customerVo.identity}',
        cellMinWidth : 95,
        height : "full-800",
        limit : 10,
        limits : [10,15,20,25],
        id : "customerListTable",
        cols : [[
            {field: 'cid', title: 'ID',align:"center"},
            {field: 'cname', title: '客户姓名', align:"center"},
            {field: 'identity', title: '身份证号', align:"center"},
            {field: 'birthday', title: '生日',align:"center"},
            {field: 'sex', title: '性别', align:'center',templet:function(data){
            	return data.sex==1?"<font color=blue>男</font>":"<font color=red>女</font>"
            }},
            {field: 'address', title: '地址',align:"center"}
        ]]
    });
          //用户列表
          tableForUser = table.render({
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
          	var id=obj.data.cid;
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
      			content:'${ctx}/user/toUpdateUser.action?cid='+id,
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
         		  $.post("${ctx}/user/deleteUser.action?cid="+id,function(result){
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
                      url+="&ids="+data[i].cid;
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