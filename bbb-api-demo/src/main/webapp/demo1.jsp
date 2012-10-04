<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Demonstra&ccedil;&otilde;o de Confer&ecirc;ncia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assets/css/docs.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
  </head>
<body>
<%@ include file="demo_header.jsp"%>
<%@ include file="bbb_api.jsp"%>
<% 
	if (request.getParameterMap().isEmpty()) {
%> 

<div class="container-fluid">

<div class="hero-unit">
	<h2>Entrar na Demonstra&ccedil;&atilde;o de Confer&ecirc;ncia</h2>
</div>

<div class="row-fluid">
	<form name="form1" class="well" method="GET">
	  <input type=hidden name=action value="create">
	  <label>Nome:</label>
	  <input type="text" autofocus required placeholder="Digite seu nome" name="username">
	  <div class="form-actions">
	  	<button type="submit" class="btn btn-primary">Entrar</button>
	  </div>
	</form>
</div>

<%
} else  if (request.getParameter("action").equals("create")) {
	
	//
	// Got an action=create
	//
	
	String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
	// String preUploadPDF = "<?xml version='1.0' encoding='UTF-8'?><modules><module name='presentation'><document url='"+url+"pdfs/sample.pdf'/></module></modules>";
	String joinURL = getJoinURL(request.getParameter("username"), "Demonstracao de conferencia", "false", null, null, null);

	if (joinURL.startsWith("http://")) { 
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} else {
%>

Erro: getJoinURL() falhou
<p/>
<%=joinURL %>

<% 
	}
} 
%>

</div>

<hr>

<%@ include file="demo_footer.jsp"%>

    <script src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-transition.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-alert.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-modal.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-dropdown.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-scrollspy.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tab.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tooltip.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-popover.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-button.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-collapse.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-carousel.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-typeahead.js"></script>
</body>
</html>
