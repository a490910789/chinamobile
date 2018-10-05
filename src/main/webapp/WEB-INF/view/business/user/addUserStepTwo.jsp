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
  <legend>开户 step-2</legend>
</fieldset>
<div style="width: 50%;height: 100%">
	<form lay-filter="fm" class="layui-form layui-form-pane" action="${ctx }/user/addUserStepTwo.action" method="post"
		id="fm">
		<input type="hidden" name="cname" value="${customer.cname }">
		<input type="hidden" name="address" value="${customer.address }">
		<div class="layui-form-item">
			<label class="layui-form-label">客户ID</label>
			<div class="layui-input-block">
				<input type="text" name="customerid" value="${customer.cid }" readonly="readonly" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">账户ID</label>
			<div class="layui-input-block">
				<input type="text" name="accountid" value="${user.accountid }" readonly="readonly" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号码</label>
			<div class="layui-input-block">
				<input type="text" name="phone" lay-verify="required"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">漫游状态</label>
			  <div class="layui-input-block">
			    <input type="radio" name="roaming" value="p" title="省内漫游">
			    <input type="radio" name="roaming" value="d" title="国内漫游">
			    <input type="radio" name="roaming" value="i" title="国际漫游">
			  </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">通话级别</label>
			  <div class="layui-input-block">
			    <input type="radio" name="calllevel" value="l" title="省内漫游">
			    <input type="radio" name="calllevel" value="d" title="国内漫游">
			    <input type="radio" name="calllevel" value="i" title="国际漫游">
			  </div>
		</div>
			<div style="text-align: center;">
				<button class="layui-btn" lay-submit="" lay-filter="next">下一步</button>
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
		form.on("submit(next)", function(data) {
			 $("#fm").submit();
		});
	});
</script>
</html>