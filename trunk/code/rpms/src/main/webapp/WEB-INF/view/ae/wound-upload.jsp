<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="exam-wound-upload-form" method="post" style="margin-top: 10px;" enctype="multipart/form-data">
    <table class="layout-table" cellpadding="4">
        <input type="hidden" name="examId" id="wound-exam-upload-id" value="${exam.id}"/>
        <tr>
            <td style="text-align: right;vertical-align: top;"><span style="color: red;">*</span>图片文件：</td>
            <td>
                <input style="width: 250px;" type="file" name="photo" class="easyui-validatebox"
                       data-options="required:true" id="photo-file">
            </td>
        </tr>
        <tr>
            <td></td>
            <td>支持的图片文件格式：.png,.jpg,.jpeg,.gif，大小不能超过1M.</td>
        </tr>
        <tr>
            <td style="text-align: right">文件名称：</td>
            <td><input style="width: 250px;" type="text" name="name"></td>
        </tr>
        <tr>
            <td></td>
            <td>如果文件名不填写，默认为文件原名称.</td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">描述：</td>
            <td><textarea name="description" style="width: 250px;height: 80px;"></textarea></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea name="remark" style="width: 250px;height: 80px;"></textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        parent.$.messager.progress('close');
        var SUPPORT_FILE_SUFFIX = /\.(jpe?g|png|gif)$/i;
        var SUPPORT_FILE_TYPE = /(image)/i;
        var SUPPORT_FILE_MAX_SIZE = 1; // 最大支持1M的图片上传
        $('input[type=file]').ace_file_input({
            no_file: '未选择任何图片文件',
            btn_choose: '点击选择图片文件',
            btn_change: '',
            no_icon: 'icon-picture',
            droppable: false, // 是否可以直接拖入文件
            thumbnail: 'large', // large, fit, small, true, false —— 压缩并预览
            style: 'well', // 'well', false —— 显示效果，well支持预览，并支持多个文件上传
            preview_error: null,
            before_remove: function () {
                return false;
            },

            before_change: function (files, dropped) {
                var file = files[0];
                if (typeof file == "string") {//files is just a file name here (in browsers that don't support
                    if (!SUPPORT_FILE_SUFFIX.test(file)) {
                        alert('不支持的文件类型!');
                        return false;
                    }
                } else {
                    var type = $.trim(file.type);
                    if (type.length > 0 && !SUPPORT_FILE_TYPE.test(type) || type.length == 0 && !SUPPORT_FILE_SUFFIX.test(file.name)) //for android's default browser!
                    {
                        alert('不支持的文件类型!');
                        return false;
                    }
                    if (file.size > SUPPORT_FILE_MAX_SIZE * 1024 * 1024) {
                        alert('仅支持最大' + SUPPORT_FILE_MAX_SIZE + 'M的文件上传!');
                        return false;
                    }
                }
                return true;
            }
        });

        $('.ace-file-input').find('.remove').remove();
        $('.ace-file-input').width('250px');
        $('.file-label').height('150px');

        $('#exam-wound-upload-form').form({
            url: getContentPath() + '/exam/uploadWound.do',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
                    refreshTab();
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });
</script>