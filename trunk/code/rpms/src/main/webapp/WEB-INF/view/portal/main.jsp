<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/inc.jsp" %>
</head>
<body id="ccptBody">
<div id="index_layout">
    <!-- 北部 -->
    <div data-options="region:'north'" style="height: 70px; overflow: hidden;" class="logo">
        <div id="logo-img"></div>
        <div id="sessionInfoDiv" style="position: absolute; right: 90px; top: 10px;">
            [<strong><s:authentication property="name"/></strong>]，欢迎你!
            <a href="javascript:logoutFun();"></a>
        </div>
        <div style="position: absolute; right: 0px; bottom: 0px;">
            <a href="javascript:void(0);" class="easyui-menubutton"
               data-options="menu:'#layout_north_pfMenu',iconCls:'cog'">更换皮肤</a> <a
                href="javascript:void(0);" class="easyui-menubutton"
                data-options="menu:'#layout_north_kzmbMenu',iconCls:'cog'">控制面板</a>
        </div>
        <div id="layout_north_pfMenu" style="width: 120px; display: none;">
            <div onclick="changeThemeFun('default');" title="default">default</div>
            <div onclick="changeThemeFun('gray');" title="gray">gray</div>
            <div class="menu-sep"></div>
            <div onclick="changeThemeFun('metro');" title="metro">metro</div>
            <div onclick="changeThemeFun('bootstrap');" title="bootstrap">bootstrap</div>
            <%--<div onclick="changeThemeFun('black');" title="black">black</div>
            <div class="menu-sep"></div>
            <div onclick="changeThemeFun('metro-blue');" title="metro-blue">metro-blue</div>
            <div onclick="changeThemeFun('metro-gray');" title="metro-gray">metro-gray</div>
            <div onclick="changeThemeFun('metro-green');" title="metro-green">metro-green</div>
            <div onclick="changeThemeFun('metro-orange');" title="metro-orange">metro-orange</div>
            <div onclick="changeThemeFun('metro-red');" title="metro-red">metro-red</div>--%>
        </div>
        <div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
            <div onclick="editCurrentUserPwd();">修改密码</div>
            <div class="menu-sep"></div>
            <div onclick="logoutFun();">退出登录</div>
        </div>
    </div>

    <!-- 西部导航模块 -->
    <div data-options="region:'west',split:true" title="系统菜单" style="width: 200px; overflow: hidden;padding: 20px;">
        <div data-options="fit:true,border:false">
            <ul id="layout_west_tree">
                <s:authorize ifAnyGranted="ROLE_SUPER_MANAGER,ROLE_MANAGER">
                    <li data-options="iconCls:'icon-setting'">
                        <span>系统管理</span>
                        <ul>
                            <li data-options="iconCls:'icon-user',attributes:{url:'/user/init.do'}">
                                <span>用户管理</span>
                            </li>
                            <li data-options="iconCls:'icon-count',attributes:{url:'/rp/init.do'}">
                                <span>动物信息</span>
                            </li>
                        </ul>
                    </li>
                </s:authorize>
                <s:authorize ifAnyGranted="ROLE_SUPER_MANAGER,ROLE_FEEDER">
                    <li data-options="iconCls:'icon-industry'">
                        <span>圈舍管理</span>
                        <ul>
                            <li data-options="iconCls:'icon-step',attributes:{url:'/house/init.do'}">
                                <span>圈舍及成员</span>
                            </li>
                            <li data-options="iconCls:'icon-trans',attributes:{url:'/ht/init.do'}">
                                <span>圈舍转移</span>
                            </li>
                                <%--<li data-options="iconCls:'icon-teacher',attributes:{url:'/nurture/init.do'}">
                                    <span>营养记录</span>
                                </li>
                                <li data-options="iconCls:'classs',attributes:{url:'/feed/init.do'}">
                                    <span>喂养记录</span>
                                </li>--%>
                        </ul>
                    </li>
                </s:authorize>
                <s:authorize ifAnyGranted="ROLE_SUPER_MANAGER,ROLE_FEEDER">
                    <li data-options="iconCls:'icon-box'">
                        <span>基因型管理</span>
                        <ul>
                            <li data-options="iconCls:'icon-primer',attributes:{url:'/primer/init.do'}">
                                <span>引物信息</span>
                            </li>
                            <%--<li data-options="iconCls:'classs',attributes:{url:'/gen/init.do'}">
                                <span>基因型数据</span>
                            </li>--%>
                            <li data-options="iconCls:'icon-genotype',attributes:{url:'/ag/init.do'}">
                                <span>动物基因型</span>
                            </li>
                        </ul>
                    </li>
                </s:authorize>
                <%--<s:authorize ifAnyGranted="ROLE_SUPER_MANAGER,ROLE_CODE_CARE_USER">
                    <li data-options="iconCls:'plugin'">
                        <span>医护管理</span>
                        <ul>
                            <li data-options="iconCls:'icon-teacher',attributes:{url:'/teacher/init.do'}">
                                <span>医疗记录</span>
                            </li>
                            <li data-options="iconCls:'icon-teacher',attributes:{url:'/teacher/init.do'}">
                                <span>防疫记录</span>
                            </li>
                            <li data-options="iconCls:'classs',attributes:{url:'/class/init.do'}">
                                <span>体检记录</span>
                            </li>
                            <li data-options="iconCls:'classs',attributes:{url:'/class/init.do'}">
                                <span>剖检记录</span>
                            </li>
                        </ul>
                    </li>
                </s:authorize>--%>
            </ul>
        </div>
    </div>
    <!-- 主框架 -->
    <div data-options="region:'center'" title="" style="overflow: hidden;">
        <div id="index_tabs" style="overflow: hidden;">
            <div title="首页" data-options="border:false,fit:true,href:'${ctx}/portal/welcome.do'"
                 style="overflow: hidden;">
                <%--<iframe src="${ctx}/portal/welcome.do" frameborder="0" style="border: 0; width: 100%; height: 98%;"></iframe>--%>
            </div>
        </div>
    </div>

    <%--<div data-options="region:'south',border:false" style="height: 30px; overflow: hidden;">
        <div class="panel-header panel-title" style="text-align: center; height: 100%;">版权所有©<a href="#">xxx</a></div>
    </div>--%>
</div>

<div id="index_tabsMenu" style="width: 120px; display: none;">
    <div title="refresh" data-options="iconCls:'transmit'">刷新</div>
    <div class="menu-sep"></div>
    <div title="close" data-options="iconCls:'delete'">关闭</div>
    <div title="closeOther" data-options="iconCls:'delete'">关闭其他</div>
    <div title="closeAll" data-options="iconCls:'delete'">关闭所有</div>
</div>

<div id="editCurrentUserPwdDiglog"></div>

<%@ include file="../common/js.jsp" %>
<script type="text/javascript" src="${ctx}/assets/js/layout/main.js"></script>
<script type="text/javascript" src="${ctx}/assets/js/layout/north.js"></script>
<script type="text/javascript" src="${ctx}/assets/js/layout/west.js"></script>
</body>
</html>