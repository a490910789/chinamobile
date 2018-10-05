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
  <legend>查询条件</legend>
</fieldset>
<form class="layui-form" id="fm" >
   <div class="layui-form-item layui-inline">
      <label class="layui-form-label">客户名称</label>
      <div class="layui-input-inline">
        <input type="text" name="cname" id="cname"   autocomplete="off" class="layui-input">
      </div>
      <label class="layui-form-label">身份证号</label>
      <div class="layui-input-inline">
        <input type="text" name="identity"  id="identity" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
       <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
       <button type="reset" class="layui-btn layui-btn-warm">重置</button>
   </div>
 </form>
	<table id="customerList" lay-filter="customerList"></table>
 
	<!-- 操作 -->
	<script type="text/html" id="customerListBar">
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
            cname: $("#cname").val(),  //搜索的关键字
            identity: $("#identity").val(),  //搜索的关键字
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
        
    //登入客户列表
        tableIns = table.render({
        elem: '#customerList',
        url : '${ctx }/customer/queryAllCustomer.action',
        cellMinWidth : 95,
        toolbar: '#tableToolBar',
        page : true,
        height : "full-180",
        limit : 10,
        limits : [10,15,20,25],
        defaultToolbar: ['filter'],
        id : "customerListTable",
        cols : [[
            {field: 'cid', title: 'ID',align:"center"},
            {field: 'cname', title: '客户姓名', align:"center"},
            {field: 'identity', title: '身份证号', align:"center"},
            {field: 'birthday', title: '生日',align:"center"},
            {field: 'sex', title: '性别', align:'center',templet:function(data){
            	return data.sex==1?"<font color=blue>男</font>":"<font color=red>女</font>"
            }},
            {field: 'address', title: '地址',align:"center"},
            {title: '操作', width:150, templet:'#customerListBar',fixed:"right",align:"center"}
        ]]
    });
    
      //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
        $(".search_btn").on("click",function(){
        	  reloadTable(null);
        });

       //监听按钮
    table.on('toolbar(customerList)', function(obj){
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
    table.on('tool(customerList)', function(obj){
    	var id=obj.data.cid;
    	switch (obj.event) {
		case "delete":
			deleteCustomer(id);
			break;
		case "update":
			updateCustomer(id);
			break;
    	}
    });
    
    //修改
    function updateCustomer(id){
    	layer.open({
			title:['修改客户'],  
			type:2,
			content:'${ctx}/customer/toUpdateCustomer.action?cid='+id,
			area:['800px','550px'],
			maxmin:true,
			success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回客户列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
		});
    }
    
    //删除单个
    function deleteCustomer(id){
    	 layer.confirm('确定删除选中的客户？', {icon: 3, title: '提示信息'}, function (index) {
   		  $.post("${ctx}/customer/deleteCustomer.action?cid="+id,function(result){
   	          	layer.msg(result.msg);
                tableIns.reload();
   	        });
        });
     }
});

</script>
</body>
</html>