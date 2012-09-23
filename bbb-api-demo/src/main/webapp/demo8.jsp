<html> 
 <head><title>Entrar & Enviar Apresentacao (URL)</title></head></p> <p>
 <body>
 <%@ include file="bbb_api.jsp"%>  

<%
	String welcome = "<br>Bem vindo a <b>%%CONFNAME%%</b>!";

        if (request.getParameterMap().isEmpty()) {
		HashMap<String, String> presentations = new HashMap<String, String>();

		presentations.put( "Virtools.pptx", "Virtools.pptx" );
		presentations.put( "apresentacao1.pdf", "pdfs/apresentacao1.pdf" );
		presentations.put( "apresentacao2.pdf", "pdfs/apresentacao2.pdf" );
		presentations.put( "apresentacao3.pdf", "pdfs/apresentacao3.pdf" );
%>

<%@ include file="demo_header.jsp"%>

<h2>Entrar & Enviar Apresentacao (URL)</h2> 
		<FORM NAME="form1" METHOD="GET">
			<table cellpadding="5" cellspacing="5" style="width: 400px;">
				<tbody>
					<tr>
						<td>&nbsp;</td>
						<td style="text-align: right;">Nome Completo:</td>
						<td style="width: 5px;">&nbsp;</td>
						<td style="text-align: left"><input type="text" autofocus required 
							name="username" />
						</td>
					</tr>
	
					<tr>
						<td>&nbsp;</td>
						<td style="text-align: right">Preenviar:</td>
						<td style="width: 5px;">&nbsp;</td>
						<td><select name=presentationFileName>
                        <%
				Iterator<String> presentationsIterator = new TreeSet<String>(presentations.keySet()).iterator();
				String key;

                                while (presentationsIterator.hasNext()) {
                                        key = presentationsIterator.next();
                                        out.println("<option value=\"" + presentations.get(key) + "\">" + key + "</option>");
                                }

                        %>
						</select>
						</td>
					</tr>
	
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input type="submit" value="Entrar" />
						</td>
					</tr>
				</tbody>
			</table>
			<INPUT TYPE=hidden NAME=action VALUE="create">
	</form>
 </body>
</html>

<%
} else if (request.getParameter("action").equals("create")) {
        
         // Got an action=create
  
        String username = request.getParameter("username");
        String presentationFileName = request.getParameter("presentationFileName");
	
	String demoURL = BigBlueButtonURL.replace("bigbluebutton/","demo/");
	String xml = "<?xml version='1.0' encoding='UTF-8'?> <modules>	<module name='presentation'> <document url='"+demoURL+presentationFileName+"' /> </module></modules>";
	String welcomeMsg = "A apresentacao sera carregada em instantes.  Para fazer o download <a href=\"event:"+ demoURL+presentationFileName+ "\"><u>" + presentationFileName +"</u></a>.<br>" + welcome;

	String meetingID = presentationFileName.replace("pdfs/","").replace(".pdf","").replace(".pptx","");
	String joinURL = getJoinURL(username, meetingID, "false", welcomeMsg, null, xml );

	if (joinURL.startsWith("http://")) { 
		%>
		<script language="javascript" type="text/javascript">
		  window.location.href="<%=joinURL%>";
		</script>

		<%
		} else {
		%>

		Erro: getJoinURL() falhou
		<p />
		<%=joinURL %>
			<% 
				}
}
%>
</body>
</html>
