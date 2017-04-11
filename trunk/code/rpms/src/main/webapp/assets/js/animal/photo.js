/**
 * 动物管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function () {
    var animalId = $('#photo-animal-id').val();
    $('#photo-upload').click(function () {
        parent.$.modalDialog({
            title: '照片上传',
            width: 500,
            height: 600,
            href: getContentPath() + '/rp/toPhotoUploadPage.do?animalId=' + animalId,
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
            title: '编辑照片信息',
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
            ajax(getContentPath() + "/rp/deletePhoto.do", {
                animalId: $('#photo-animal-id').val(),
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
        var animalId = $('#photo-animal-id').val();
        parent.$.modalDialog({
            title: '照片浏览',
            width: $(window).outerWidth() - 200,
            height: $(window).outerHeight() - 20,
            href: getContentPath() + '/rp/toShowPhotoPage.do?animalId=' + animalId
        });
    });
});