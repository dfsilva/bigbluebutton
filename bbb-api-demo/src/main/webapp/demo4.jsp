<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<%@page import="org.w3c.dom.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Monitor de Atividade</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.css" rel="stylesheet">
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/redmond/jquery-ui-redmond.css" />
	
    <style type="text/css">
	.hiddenDiv {display:none;}
	.hor-minimalist-b{font-family:"Lucida Sans Unicode", "Lucida Grande", Sans-Serif;font-size:12px;background:#fff;width:480px;border-collapse:collapse;text-align:left;margin:20px;}.hor-minimalist-b th{font-size:14px;font-weight:normal;color:#039;border-bottom:2px solid #6678b1;padding:10px 8px;}.hor-minimalist-b td{border-bottom:1px solid #ccc;color:#669;padding:6px 8px;width:100px;}.hor-minimalist-b tbody tr:hover td{color:#009;}</style>
    
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
    
    <script src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/demo4.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/md5.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.xml2json.js"></script>
  </head>
<body>
<%@ include file="bbb_api.jsp"%>
<%@ include file="demo_header.jsp"%>
<%
if (request.getParameterMap().isEmpty()) {
%>
<div class="container-fluid">
	<div class="hero-unit">
		<h2>Monitor de Atividade</h2>
	</div>
<p id="no_meetings"></p>

<div id="meetings"></div>
<% 
} else if (request.getParameter("action").equals("end")) {
	 
	String mp = request.getParameter("moderatorPW");
	String meetingID = request.getParameter("meetingID");
	
	String result = endMeeting(meetingID, mp);
	
	if ( result.equals("true") ){

%>
	<div class="hero-unit">
		<h2>Monitor de Atividade</h2>
	</div>

<%=meetingID%> foi concluida.

<p id="no_meetings"></p>

<div id="meetings"></div>

<% } else { %>

	<div class="hero-unit">
		<h2>Monitor de Atividade</h2>
	</div>
	
	Impossivel terminar a reuniao: <%=meetingID%>

<%=result%>

<% 		}
	}%>
	
</div>
<%@ include file="demo_footer.jsp"%>

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

 

