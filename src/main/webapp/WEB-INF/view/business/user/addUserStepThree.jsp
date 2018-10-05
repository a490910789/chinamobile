<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>开户</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctx }/resources/plugin/css/index.css">
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
  <legend>开户 step-3</legend>
</fieldset>
<div style="width: 50%;height: 100%">
	<form lay-filter="fm" class="layui-form layui-form-pane" action="#" method="post"
		id="fm">
		<input type="hidden" name="phone" value="${userVo.phone }">
		<div class="layui-form-item">
			<label class="layui-form-label">账户ID</label>
			<div class="layui-input-block">
				<input type="text" name="aid" value="${account.aid }" readonly="readonly" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">姓名</label>
			<div class="layui-input-block">
				<input type="text" name="cname" value="${account.person }" readonly="readonly" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">联系地址</label>
			<div class="layui-input-block">
				<input type="text" name="address" value="${account.address }"  lay-verify="required"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">余额</label>
			<div class="layui-input-block">
				<input type="text" name="balance" value="${account.balance }" readonly="readonly"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">开户金额</label>
			<div class="layui-input-block">
				<input type="text" name="recharge"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
			<div style="text-align: center;">
				<a href="javascript:void(0)" class="layui-btn" lay-submit=""
					lay-filter="formSubmit">提交</a>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
	</form>
	</div>
</body>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript">
	layui.use([ 'form', 'jquery'], function() {
		var form = layui.form,
		$ = layui.jquery;
		//提交
		form.on("submit(formSubmit)", function(data) {
			var params = $('#fm').serialize();
			$.post("${ctx}/user/addUserStepThree.action?" + params, function(result) {
					layer.msg(result.msg);//弹出添加成功或失败
				    setTimeout(function(){
					window.location.href="${ctx }/user/toUserManager.action";
	            },500);
			});
		});
	});
</script>
</html>