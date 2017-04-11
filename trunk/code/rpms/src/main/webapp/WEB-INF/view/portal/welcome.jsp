<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tag.jsp" %>
<div id="portalLayout" class="easyui-layout" data-options="fit:true">
    <div data-options="region:'center',border:false,title:'欢迎'" style="text-align: center">
        <%--<img src="${ctx}/assets/imgs/welcome.jpg" height="428" width="490"/>--%>
        <h3 style="margin-top: 200px;"><strong><s:authentication property="name"/></strong>，欢迎进入小熊猫、丹顶鹤微卫星数据管理系统！</h3>
        <%--<div style="text-align: center">
        <table border="1" width="70%" cellpadding="0" cellspacing="0" style="margin: auto">
            <tr>
                <th style="text-align: center">丹顶鹤在养数量</th>
                <th style="text-align: center">小熊猫在养数量</th>
            </tr>
        </table>
        </div>--%>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    var portalLayout;
    var portal;
    $(function () {
        portalLayout = $('#portalLayout').layout({
            fit: true
        });
        $(window).resize(function () {
            portalLayout.layout('panel', 'center').panel('resize', {
                width: 1,
                height: 1
            });
        });

        /*panels = [
            {
                id: 'p1',
                title: '欢迎',
                fit: true,
                height: 400,
                //                collapsible: true,
                href: getContentPath() + '/portal/news.do'
            },
            {
                id: 'p2',
                title: '通知',
                height: 200,
                collapsible: true,
                //                href: getContentPath() + '/portal/notice.do'
            },
            {
                id: 'p3',
                title: '消息',
                height: 200,
                collapsible: true,
                //                href: getContentPath() + '/portal/notice.do'
            }
        ];

        portal = $('#portal').portal({
            border: false,
            fit: true,
            onStateChange: function () {
                $.cookie('portal-state', getPortalState(), {
                    expires: 4
                });
            }
        });
        var state = $.cookie('portal-state');
        if (!state) {
            *//*冒号代表列，逗号代表行*//*
            state = 'p1:p2,p3';
        }
        addPortalPanels(state);
        portal.portal('resize');*/
    });

    function getPanelOptions(id) {
        for (var i = 0; i < panels.length; i++) {
            if (panels[i].id == id) {
                return panels[i];
            }
        }
        return undefined;
    }

    function getPortalState() {
        var aa = [];
        for (var columnIndex = 0; columnIndex < 2; columnIndex++) {
            var cc = [];
            var panels = portal.portal('getPanels', columnIndex);
            for (var i = 0; i < panels.length; i++) {
                cc.push(panels[i].attr('id'));
            }
            aa.push(cc.join(','));
        }
        return aa.join(':');
    }

    function addPortalPanels(portalState) {
        var columns = portalState.split(':');
        for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
            var cc = columns[columnIndex].split(',');
            for (var j = 0; j < cc.length; j++) {
                var options = getPanelOptions(cc[j]);
                if (options) {
                    var p = $('<div/>').attr('id', options.id).appendTo('body');
                    p.panel(options);
                    portal.portal('add', {
                        panel: p,
                        columnIndex: columnIndex
                    });
                }
            }
        }
    }
</script>