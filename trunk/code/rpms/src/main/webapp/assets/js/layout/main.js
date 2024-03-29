var index_tabs;
var index_tabs;
var index_tabsMenu;
var index_layout;
$(function () {
    index_layout = $('#index_layout').layout({
        fit: true
    });
//	index_layout.layout('collapse', 'south');
    index_tabs = $('#index_tabs').tabs({
        fit: true,
        border: false,
        onContextMenu: function (e, title) {
            e.preventDefault();
            index_tabsMenu.menu('show', {
                left: e.pageX,
                top: e.pageY
            }).data('tabTitle', title);
        },
        tools: [
            {
                iconCls: 'database_refresh',
                handler: function () {
                    var href = index_tabs.tabs('getSelected').panel('options').href;
                    if (href) {/*说明tab是以href方式引入的目标页面*/
                        var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
                        index_tabs.tabs('getTab', index).panel('refresh');
                    } else {/*说明tab是以content方式引入的目标页面*/
                        var panel = index_tabs.tabs('getSelected').panel('panel');
                        var frame = panel.find('iframe');
                        try {
                            if (frame.length > 0) {
                                for (var i = 0; i < frame.length; i++) {
                                    frame[i].contentWindow.document.write('');
                                    frame[i].contentWindow.close();
                                    frame[i].src = frame[i].src;
                                }
                                if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
                                    try {
                                        CollectGarbage();
                                    } catch (e) {
                                    }
                                }
                            }
                        } catch (e) {
                        }
                    }
                }
            },
            {
                iconCls: 'delete',
                handler: function () {
                    var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
                    var tab = index_tabs.tabs('getTab', index);
                    if (tab.panel('options').closable) {
                        index_tabs.tabs('close', index);
                    } else {
                        $.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
                    }
                }
            }
        ]
    });

    index_tabsMenu = $('#index_tabsMenu').menu({
        onClick: function (item) {
            var curTabTitle = $(this).data('tabTitle');
            var type = $(item.target).attr('title');

            if (type === 'refresh') {
                index_tabs.tabs('getTab', curTabTitle).panel('refresh');
                return;
            }

            if (type === 'close') {
                var t = index_tabs.tabs('getTab', curTabTitle);
                if (t.panel('options').closable) {
                    index_tabs.tabs('close', curTabTitle);
                }
                return;
            }

            var allTabs = index_tabs.tabs('tabs');
            var closeTabsTitle = [];

            $.each(allTabs, function () {
                var opt = $(this).panel('options');
                if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
                    closeTabsTitle.push(opt.title);
                } else if (opt.closable && type === 'closeAll') {
                    closeTabsTitle.push(opt.title);
                }
            });

            for (var i = 0; i < closeTabsTitle.length; i++) {
                index_tabs.tabs('close', closeTabsTitle[i]);
            }
        }
    });
});