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
  <legend>开户 step-1</legend>
</fieldset>
   <div style="position: relative;margin: 30px 100px">
	<form lay-filter="fm" class="layui-form layui-form-pane" action="${ctx}/user/addUserCheckStepOne.action" method="post"
		id="fm">
		<div class="layui-form-item">
			<label class="layui-form-label">姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="cname" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">身份证号</label>
			<div class="layui-input-inline">
				<input type="text" name="identity" lay-verify="identity" autocomplete="off"
					class="layui-input">
			</div>
		</div>
			<div style="text-align: left;margin-top: 30px">
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
		//自定义验证规则
		  form.verify({
			  identity: function(value){
		      if(value.length != 18 && value.length != 15){
		    	  return "身份证不合法";
		      }
		    }
	    });
		//监听提交
		 form.on('submit(next)', function(data){
		      $("#fm").submit();
		 });
	});
</script>
</html>