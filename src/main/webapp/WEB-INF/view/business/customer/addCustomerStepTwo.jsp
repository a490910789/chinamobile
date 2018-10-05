<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加客户</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx }/resources/plugin/css/index.css">
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
  <legend>新增客户step-2</legend>
</fieldset>
	<form lay-filter="fm" class="layui-form layui-form-pane" action="#" method="post"
		id="fm">
		<div class="layui-form-item">
			<label class="layui-form-label">客户名称</label>
			<div class="layui-input-block">
				<input type="text" name="cname" value="${customerVo.cname }" readonly="readonly" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">身份证号</label>
			<div class="layui-input-block">
				<input type="text" name="identity" value="${customerVo.identity }" readonly="readonly"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">地址</label>
			<div class="layui-input-block">
				<input type="text" name="address" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生日</label>
			<div class="layui-input-block">
				<input type="text" name="birthday" id="birthday" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item ">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<input type="radio" name="sex" title="男" value="1" checked>
				<input type="radio" name="sex" title="女" value="0">
			</div>
		</div>

			<div style="text-align: center;">
				<a href="javascript:void(0)" class="layui-btn" lay-submit=""
					lay-filter="formSubmit">提交</a>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
	</form>
</body>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript">
	layui.use([ 'form', 'jquery','laydate'], function() {
		var form = layui.form,
		$ = layui.jquery,
		laydate=layui.laydate;
		laydate.render({
			elem:'#birthday'
		});
		//提交
		form.on("submit(formSubmit)", function(data) {
			var params = $('#fm').serialize();
			$.post("${ctx}/customer/addCustomer.action?" + params, function(
					result) {
			    	layer.msg(result.msg);//弹出添加成功或失败
			    setTimeout(function(){
					window.location.href="${ctx }/customer/toCustomerManager.action";
                },500)
			});
		});
	});
</script>
</html>