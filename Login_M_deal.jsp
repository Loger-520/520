<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="chStr" scope="page" class="com.tools.ChStr"/>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<%
String manager=chStr.chStr(request.getParameter("manager"));//获取管理员用户名，此处必须进行编码转换，否则输入中文用户名时将出现乱码
try{//捕捉异常
	ResultSet rs=conn.executeQuery("select * from tb_manager where manager='"+manager+"'");
	if(rs.next()){//如果找到相应的管理员用户名
		String PWD=request.getParameter("PWD");//获取密码
		if(PWD.equals(rs.getString("PWD"))){//如果输入的密码和获取的密码一致
			session.setAttribute("manager",manager);//把当前的管理员用户名保存到Session中，实现登录
			response.sendRedirect("index.jsp");//跳转到前台首页
		}else{
			out.println("<script language='javascript'>alert('您输入的管理员用户名或密码错误!');window.location.href='../index.jsp';</script>");
		}
	}else{
			out.println("<script language='javascript'>alert('您输入的管理员用户名或密码错误!');window.location.href='../index.jsp';</script>");
	}
}catch(Exception e){//处理异常
	out.println("<script language='javascript'>alert('您的操作有误!');window.location.href='../index.jsp';</script>");
}
%>
