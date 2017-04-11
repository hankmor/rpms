/**
 * 受伤情况管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function () {
    parent.$.messager.progress('close');
    var examId = $('#exam-wound-id').val();
    $('#wound-upload').click(function () {
        parent.$.modalDialog({
            title: '添加体检受伤情况',
            width: 500,
            height: 600,
            href: getContentPath() + '/exam/toWoundUploadPage.do?id=' + examId,
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
    });

    /**
     * 编辑按钮点击事件
     */
    $('.edit-btn').click(function () {
        var attaId = $(this).parents(".thumbnail").parent().find('input:hidden').val();
        parent.$.modalDialog({
            title: '编辑受伤情况',
            width: 400,
            height: 320,
            href: getContentPath() + '/atta/toUpdatePage.do?attaId=' + attaId,
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
    });

    /**
     * 删除按钮点击事件
     */
    $('.delete-btn').click(function () {
        var self = $(this);
        Dialog.confirm("该操作无法恢复，确定删除？", function () {
            ajax(getContentPath() + "/exam/deleteWound.do", {
                examId: examId,
                ids: self.parents(".thumbnail").parent().find('input:hidden').val()
            }, function () {
                refreshTab();
            }, function () {
                Dialog.error('删除失败，系统出现未知错误！', '错误');
            });
        }, '确认');
    });

    /**
     * 查看图片
     */
    $('.animal-photo').click(function () {
        parent.$.modalDialog({
            title: '照片浏览',
            width: $(window).outerWidth() - 200,
            height: $(window).outerHeight() - 20,
            href: getContentPath() + '/exam/toShowWoundPage.do?examId=' + examId
        });
    });
});