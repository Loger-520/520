<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%><%-- 导入java.sql.ResultSet类 --%>
<%-- 创建com.tools.ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB" />
<jsp:useBean id="ins_member" scope="page" class="com.dao.MemberDaoImpl"/>
<jsp:useBean id="member" scope="request" class="com.model.Member">
<jsp:setProperty name="member" property="*"/>
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>会员信息修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<%
	request.setCharacterEncoding("UTF-8");//设置请求的编码为UTF-8
	Integer id = member.getID();//获取会员ID
	String pwd = member.getPwd();//获取会员密码
	ResultSet rs = conn.executeQuery("select * from tb_Member where ID='" + id+ "'");
	String pwdSql="";
		while (rs.next()) {//如果结果集中有数据
			pwdSql = rs.getString("passWord");
		}
		if (!pwd.equals(pwdSql)) {
			out.println("<script language='javascript'>alert('原密码不正确！');window.location.href='modifyMember.jsp';</script>");
			return;
		}
	    
		int ret = 0;//记录更新记录条数的变量
		ret = ins_member.update(member);//将填写的会员信息保存到数据库
		if (ret != 0) {
		    session.setAttribute("username",member.getUsername());//将会员账号保存到Session中
			out.println("<script language='javascript'>alert('会员信息修改成功！');window.location.href='index.jsp';</script>");
		} else {
			out.println("<script language='javascript'>alert('会员信息修改失败！');window.location.href='modifyMember.jsp';</script>");
		}
%>
</body>
</html>
