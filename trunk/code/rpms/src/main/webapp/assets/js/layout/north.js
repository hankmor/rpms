function changeThemeFun(themeName) {
    if ($.cookie('easyuiThemeName')) {
        $('#layout_north_pfMenu').menu('setIcon', {
            target: $('#layout_north_pfMenu div[title=' + $.cookie('easyuiThemeName') + ']')[0],
            iconCls: 'emptyIcon'
        });
    }
    $('#layout_north_pfMenu').menu('setIcon', {
        target: $('#layout_north_pfMenu div[title=' + themeName + ']')[0],
        iconCls: 'tick'
    });

    var $easyuiTheme = $('#easyuiTheme');
    var url = $easyuiTheme.attr('href');
    var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
    $easyuiTheme.attr('href', href);

    var $iframe = $('iframe');
    if ($iframe.length > 0) {
        for (var i = 0; i < $iframe.length; i++) {
            var ifr = $iframe[i];
            try {
                $(ifr).contents().find('#easyuiTheme').attr('href', href);
            } catch (e) {
                try {
                    ifr.contentWindow.document.getElementById('easyuiTheme').href = href;
                } catch (e) {
                }
            }
        }
    }

    $.cookie('easyuiThemeName', themeName, {
        expires: 7
    });

};

function logoutFun() {
    location.replace(location.href = getContentPath() + "/j_spring_security_logout");
}

function editCurrentUserPwd() {
    parent.$.modalDialog({
        title: '修改密码',
        width: 350,
        height: 250,
        href: getContentPath() + '/user/editPwd.do',
        buttons: [
            {
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    var f = parent.$.modalDialog.handler.find('form');
                    f.submit();
                }
            },
            {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    parent.$.modalDialog.handler.dialog('close');
                }
            }
        ]
    });
}