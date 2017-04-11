<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="red-panda-add-form" method="post" style="margin-top: 10px;">
    <table class="layout-table" cellpadding="4">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>编号：</td>
            <td><input name="tatooCode" type="text" class="easyui-validatebox" validType='sameNo["/rp/sameNo.do"]'></td>
            <td style="text-align: right">电子芯片号：</td>
            <td><input name="microchipCode" type="text" class="easyui-validatebox" validType='sameNo["/rp/sameChipNo.do"]'></td>
        </tr>
        <tr>
            <td></td>
            <td>（确定后不能修改）</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td style="text-align: right">谱系编号：</td>
            <td><input name="studbookCode" type="text" class="easyui-validatebox"></td>
            <td style="text-align: right">耳号：</td>
            <td><input name="earCode" type="text" class="easyui-validatebox"></td>
        </tr>
        <tr>
            <td style="text-align: right">唇号：</td>
            <td><input name="lipCode" type="text" class="easyui-validatebox"></td>
            <td style="text-align: right">呼名：</td>
            <td><input name="name" type="text" class="easyui-validatebox"></td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td style="text-align: right">姓别：</td>
            <td>
                <label class="checkbox-inline">
                    <input type="radio" name="sex" value="true" checked>雄性
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="sex" value="false">雌性
                </label>
            </td>
            <td style="text-align: right">年龄：</td>
            <td><input name="age" type="text" class="easyui-validatebox" validType="digit"></td>
        </tr>
        <tr>
            <td style="text-align: right">父亲：</td>
            <td>
                <select name="animalByFather.id" id="red-panda-add-father-table" style="width: 153px"
                                 class="easyui-combogrid"
                                 data-options="
                    panelWidth: 600,
                    nowrap : true,
                    pagination : true,
                    rownumbers : true,
                    fit : true,
                    mode : 'remote',
                    editable : false,
                    idField: 'id',
                    textField: 'microchipCode',
                    url: getContentPath() + '/rp/pager.do',
                    method: 'post',
                    columns: [[
                        {field : 'microchipCode', title : '芯片号', width : 70, align: 'center'},
                        { field : 'studbookCode', title : '谱系号', width : 70, align: 'center'},
                        { field : 'name', title : '名称', width : 70, align: 'center'},
                        { field : 'houseNumber', title : '所在圈舍编号', width : 70, align: 'center'},
                        { field : 'fatherChipCode', title : '父亲芯片号', width : 70, align: 'center'},
                        { field : 'motherChipCode', title : '母亲芯片号', width : 70, align: 'center'},
                        { field : 'birthDate', title : '出生日期', width : 100, align: 'center'},
                        { field : 'status', title : '状态', width : 40, align: 'center', formatter : function (value, row, index) {
                            if (value == RED_PANDA.STATUS_TRANS_OUT)
                                return '<span style=\'color: red;\'>转出</span>';
                            else if (value == RED_PANDA.STATUS_FEEDING)
                                return '<span style=\'color: green;\'>在养</span>';
                            else if (value == RED_PANDA.STATUS_DEAD)
                                return '<span style=\'color: darkgray;\'>死亡</span>';
                        }}
                    ]],
                    fitColumns: true,
                    toolbar : '#red-panda-add-father-toolbar',
                    queryParams : {
                        'microchipCode' : $('#red-panda-add-father-search').searchbox('getValue'),
                        'sex' : true
                    }">
            </select>

                <div id="red-panda-add-father-toolbar" style="padding:5px;">
                    <input id="red-panda-add-father-search" class="easyui-searchbox" style="width:120px">
                </div>
            </td>
            <td style="text-align: right">母亲：</td>
            <td>
                <select name="animalByMother.id" id="red-panda-add-mother-table" style="width: 153px"
                        class="easyui-combogrid"
                        data-options="panelWidth: 600,
                    nowrap : true,
                    pagination : true,
                    rownumbers : true,
                    fit : true,
                    mode : 'remote',
                    editable : false,
                    idField: 'id',
                    textField: 'microchipCode',
                    url: getContentPath() + '/rp/pager.do',
                    method: 'post',
                    columns: [[
                        {field : 'microchipCode', title : '芯片号', width : 70, align: 'center'},
                        { field : 'studbookCode', title : '谱系号', width : 70, align: 'center'},
                        { field : 'name', title : '名称', width : 70, align: 'center'},
                        { field : 'houseNumber', title : '所在圈舍编号', width : 70, align: 'center'},
                        { field : 'fatherChipCode', title : '父亲芯片号', width : 70, align: 'center'},
                        { field : 'motherChipCode', title : '母亲芯片号', width : 70, align: 'center'},
                        { field : 'birthDate', title : '出生日期', width : 100, align: 'center'},
                        { field : 'status', title : '状态', width : 40, align: 'center', formatter : function (value, row, index) {
                            if (value == RED_PANDA.STATUS_TRANS_OUT)
                                return '<span style=\'color: red;\'>转出</span>';
                            else if (value == RED_PANDA.STATUS_FEEDING)
                                return '<span style=\'color: green;\'>在养</span>';
                            else if (value == RED_PANDA.STATUS_DEAD)
                                return '<span style=\'color: darkgray;\'>死亡</span>';
                        }}
                    ]],
                    fitColumns: true,
                    toolbar : '#red-panda-add-mother-toolbar',
                    queryParams : {
                        'microchipCode' : $('#red-panda-add-mother-search').searchbox('getValue'),
                        'sex' : false
                    }">
                </select>

                <div id="red-panda-add-mother-toolbar" style="padding:5px;">
                    <input id="red-panda-add-mother-search" class="easyui-searchbox" style="width:120px">
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">出生日期：</td>
            <td>
                <input type="text" style="width: 153px" class="easyui-datebox" name="birthDate">
            </td>
            <td style="text-align: right">芯片植入日期：</td>
            <td>
                <input type="text" style="width: 153" class="easyui-datebox" name="chipTime"
                       data-options="showSeconds:false">
            </td>
        </tr>
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>当前圈舍：</td>
            <td>
                <select id="red-panda-add-house-table" required="true" name="house.id" style="width: 153" class="easyui-combogrid"
                        data-options="
                    panelWidth: 500,
                    nowrap : true,
                    mode : 'remote',
                    pagination : true,
                    rownumbers : true,
                    fit : true,
                    idField: 'id',
                    editable : false,
                    textField: 'numer',
                    url: getContentPath() + '/house/pager.do',
                    method: 'post',
                    columns: [[{field : 'numer', title : '圈舍编号', width : 60, align: 'center'},
                        { field : 'name', title : '名称', width : 60, align: 'center'},
                        { field : 'location', title : '所在位置', width : 70, align: 'left'},
                        { field : 'zoo', title : '所在园区', width : 60, align: 'left'},
                        { field : 'cnt', title : '在养数量', width : 45, align: 'right'},
                        { field : 'info', title : '描述信息', width : 60, align: 'left'}
                        ]],
                    fitColumns: true,
                    toolbar : '#red-panda-add-house-toolbar',
                    queryParams : {
                        'numer' : $('#red-panda-add-house-search').searchbox('getValue')
                    }">
                </select>

                <div id="red-panda-add-house-toolbar" style="padding:5px;">
                    <input id="red-panda-add-house-search" class="easyui-searchbox" style="width:120px">
                </div>
            </td>
            <td style="text-align: right;vertical-align: top;"><span style="color: red;">*</span>物种：</td>
            <td>
                <input id="select-type" name="animalType.id">
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="3"><span>（圈舍确定后不能直接修改，可以点击圈舍转移菜单调整动物圈舍信息）</span></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">来源：</td>
            <td colspan="3">
                <input id="come-from" name="comeFrom">（如果来自外部园区，请填写其来源信息）
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td colspan="3">
                <textarea style="width: 95%;height: 60px;" name="remark"></textarea>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        $('#select-type').combobox({
            url: getContentPath() + '/at/list.do',
            valueField: 'key',
            textField: 'value',
            required: true,
            editable: false
        });

        function _red_panda_house_do_search() {
            $('#red-panda-add-house-table').combogrid('grid').datagrid("load", {
                "numer": $("#red-panda-add-house-search").searchbox('getValue')
            });
        }

        function _red_panda_father_do_search() {
            $('#red-panda-add-father-table').combogrid('grid').datagrid("load", {
                "microchipCode": $("#red-panda-add-father-search").searchbox('getValue'),
                'sex': true
            });
        }

        function _red_panda_mother_do_search() {
            $('#red-panda-add-mother-table').combogrid('grid').datagrid("load", {
                "microchipCode": $("#red-panda-add-mother-search").searchbox('getValue'),
                'sex': false
            });
        }


        $('#red-panda-add-house-search').searchbox({
            prompt: '输入编号查询',
            searcher: function () {
                _red_panda_house_do_search();
            }
        });
        $('#red-panda-add-house-search').keyup(function (e) {
            _red_panda_house_do_search();
        });

        $('#red-panda-add-father-search').searchbox({
            prompt: '输入芯片号查询',
            searcher: function () {
                _red_panda_father_do_search();
            }
        });

        $('#red-panda-add-mother-search').searchbox({
            prompt: '输入芯片号查询',
            searcher: function () {
                _red_panda_mother_do_search();
            }
        });

        parent.$.messager.progress('close');
        $('#red-panda-add-form').form({
            url: getContentPath() + '/rp/add.do',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
                    //Dialog.info(result.msg,'提示',function(){
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    //});
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });
</script>