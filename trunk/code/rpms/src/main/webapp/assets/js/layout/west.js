var layout_west_tree;

/**
 * 获取当前选中的tab页面，返回JQuery对象
 * @returns {*|jQuery|HTMLElement}
 */
function getCurTab() {
    var curTab = $('#index_tabs').tabs('getSelected');
    return $(curTab);
}

$(function () {
    layout_west_tree = $('#layout_west_tree').tree(
        {
            onClick: function (node) {
                if (node.attributes && node.attributes.url) {
                    var url;
                    if (node.attributes.url.indexOf('/') == 0) {/* 如果url第一位字符是"/"，那么代表打开的是本地的资源 */
                        url = getContentPath() + node.attributes.url;
                    } else {/* 打开跨域资源 */
                        url = node.attributes.url;
                    }
                    addTab({
                        url: url,
                        title: node.text,
                        iconCls: node.iconCls
                    });
                }
            }
        });
});

/**
 * 添加tab页面
 * @param params
 * @param newTab 是否关闭原来的重新添加一个，默认false
 */
function addTab(params, newTab) {
    try {
        var t = $('#index_tabs');
        var opts = {
            title: params.title,
            closable: true,
            iconCls: params.iconCls,
            //content : ,
            cache: false,
            href: params.url,
            border: false,
            fit: true
        };
        if (t.tabs('exists', opts.title)) {
            if (newTab) {
                // 关闭原有的，重新添加一个
                t.tabs('close', opts.title);
                t.tabs('add', opts);
            } else {
                t.tabs('select', opts.title);
            }
        } else {
            t.tabs('add', opts);
        }
    } catch (e) {
    }
}

/**
 * 刷新当前选择的标签页
 */
function refreshTab() {
    var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
    index_tabs.tabs('getTab', index).panel('refresh');
}