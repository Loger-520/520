<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="com.dao.SuperTypeDaoImpl"%>
<jsp:useBean id="SuperType" scope="page" class="com.model.SuperType">
<jsp:setProperty name="SuperType" property="*"/>
</jsp:useBean>
<jsp:useBean id="chStr" scope="page" class="com.tools.ChStr"/>
<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<jsp:include page="safe.jsp"/>
<%
String typename=chStr.chStr(SuperType.gettypename());//获取商品种类名称
ResultSet rs=conn.executeQuery("select * from tb_superType where typename='"+typename+"'");
if (rs.next()){//如果结果集中有数据
	out.println("<script language='javascript'>alert('该大分类信息已经添加，请添加新的大分类信息！');window.location.href='super_add.jsp';</script>");
}else{
	int ret=0;//记录更新记录条数的变量
        SuperTypeDaoImpl ins_SuperType=new SuperTypeDaoImpl();
        ret=ins_SuperType.insert(SuperType);//将填写的商品种类名称保存到数据库
	if (ret!=0){
          out.println("<script language='javascript'>alert('大分类信息添加成功！');window.location.href='superType.jsp';</script>");
        }else{
          out.println("<script language='javascript'>alert('大分类信息添加失败！');window.location.href='super_add.jsp';</script>");
        }
}
%>