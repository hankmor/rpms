/**
 * 动物管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */
$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#genotype-animal-table').datagrid({
        title: "动物列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        singleSelect: false,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/rp/pager.do',
        frozenColumns: [
            [
                {
                    field: 'id',
                    align: 'center',
                    checkbox: true
                }
            ]
        ],
        columns: [
            [
                {field: 'typeName', title: '物种', width: 50, align: 'center'},
                {field: 'tatooCode', title: '编号', width: 50, align: 'center'},
                {field: 'microchipCode', title: '芯片号', width: 70, align: 'center'},
                { field: 'studbookCode', title: '谱系号', width: 70, align: 'center'},
                { field: 'name', title: '呼名', width: 70, align: 'center'},
                { field: 'sex', title: '性别', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == SEX.FEMALE)
                        return "雌性";
                    else if (value == SEX.MALE)
                        return "雄性";
                }},
                { field: 'age', title: '年龄', width: 40, align: 'center'},
                { field: 'status', title: '状态', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == RED_PANDA.STATUS_TRANS_OUT)
                        return "<span style='color: red;'>转出</span>";
                    else if (value == RED_PANDA.STATUS_FEEDING)
                        return "<span style='color: green;'>在养</span>";
                    else if (value == RED_PANDA.STATUS_DEAD)
                        return "<span style='color: darkgray;'>死亡</span>";
                }},
                { field: 'birthDate', title: '出生日期', width: 100, align: 'center'},
                { field: 'houseNumber', title: '所在圈舍编号', width: 70, align: 'center'},
                { field: 'fatherChipCode', title: '父亲芯片号', width: 70, align: 'center'},
                { field: 'motherChipCode', title: '母亲芯片号', width: 70, align: 'center'}
            ]
        ],
        queryParams: {
            "microchipCode": $("#genotype-animal-chipNo").val(),
            "queryGenotypes": false,
            "no" : $('#genotype-animal-no').val()
        },
        toolbar: '#ag-toolbar',
        view: detailview,
        detailFormatter: function (index, row) {
            return "<div style='padding:2px'>" +
                "<div style=\"padding:5px;\" class=\"datagrid-toolbar\">" +
                "<table><tr>" +
                "<td><label>引物编号：</label></td><td><input class=\"search-box primerNo\" type=\"text\"/></td>" +
                "<td><label>基因型A：</label></td><td><input class=\"search-box codeA\" type=\"text\"/></td>" +
                "<td><label>基因型B：</label></td><td><input class=\"search-box codeB\" type=\"text\"/></td>" +
                "<td><a href=\"javascript:void(0)\" class=\"easyui-linkbutton l-btn search\" iconcls=\"icon-search\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-search l-btn-icon-left\">查询</span></span></a></td>" +
                "</tr></table>" +
                "<a href=\"javascript:void(0);\" class=\"easyui-linkbutton l-btn l-btn-plain add\" iconcls=\"icon-add\" plain=\"true\" group=\"\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-add l-btn-icon-left\">添加</span></span></a>" +
                "<a href=\"javascript:void(0);\" class=\"easyui-linkbutton l-btn l-btn-plain remove\" iconcls=\"icon-remove\" plain=\"true\" group=\"\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-remove l-btn-icon-left\">删除</span></span></a>" +
                "</div>" +
                "<table class='hm'></table>" +
                "</div>";
        },
        onExpandRow: function (index, row) {
            var genotypeInAnimal = $(this).datagrid('getRowDetail', index).find('table.hm');
            var toolBar = $(this).datagrid('getRowDetail', index).find('.datagrid-toolbar');
            var subGrid = genotypeInAnimal.datagrid({
                url: getContentPath() + '/ag/pager.do',
                fitColumns: true,
                singleSelect: false,
                checkOnSelect: true,
                selectOnCheck: true,
                nowrap: true,
                pagination: true,
                rownumbers: true,
                loadMsg: 'loading...',
                height: 'auto',
                toolbar: toolBar,
                queryParams: {
                    "animalId": row.id,
                    "primerNo": toolBar.find('.primerNo').val(),
                    "codeA": toolBar.find('.codeA').val(),
                    "codeB": toolBar.find('.codeB').val()
                },
                frozenColumns: [
                    [
                        {
                            field: 'id',
                            align: 'center',
                            checkbox: true
                        }
                    ]
                ],
                columns: [
                    [
                        {field: 'codeA', title: '基因型A', width: 100, align: 'center'},
                        {field: 'codeB', title: '基因型B', width: 100, align: 'center'},
                        {field: 'primerNo', title: '对应引物编号', width: 100, align: 'center'},
                        {field: 'createTime', title: '创建时间', width: 80, align: 'center'},
                    ]
                ],
                onResize: function () {
                    $('#genotype-animal-table').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#genotype-animal-table').datagrid('fixDetailRowHeight', index);
                    }, 0);
                }
            });
            $('#genotype-animal-table').datagrid('fixDetailRowHeight', index);

            // 注册事件，防止重复绑定
            toolBar.find('.add').unbind('click').bind('click', function () {
                _animal_genotype_setAddForm(row, subGrid);
            });

            toolBar.find('.remove').unbind('click').bind('click', function () {
                var codeA = toolBar.find('.codeA').val();
                var codeB = toolBar.find('.codeB').val();
                var primerNo = toolBar.find('.primerNo').val();
                _animal_genotype_remove(codeA, codeB, primerNo, row, subGrid);
            });

            toolBar.find('.search').unbind('click').bind('click', function () {
                var codeA = toolBar.find('.codeA').val();
                var codeB = toolBar.find('.codeB').val();
                var primerNo = toolBar.find('.primerNo').val();
                _animal_genotype_reloadDataGrid(codeA, codeB, primerNo, row, subGrid);
            });

            /*toolBar.on('click', '.add', function () {
             _animal_genotype_setAddForm(row, subGrid);
             });
             toolBar.on('click', '.remove', function () {
             var codeA = toolBar.find('.codeA').val();
             var codeB = toolBar.find('.codeB').val();
             var primerNo = toolBar.find('.primerNo').val();
             _animal_genotype_remove(codeA, codeB, primerNo, row, subGrid);
             });
             toolBar.on('click', '.search', function () {
             var codeA = toolBar.find('.codeA').val();
             var codeB = toolBar.find('.codeB').val();
             var primerNo = toolBar.find('.primerNo').val();
             _animal_genotype_reloadDataGrid(codeA, codeB, primerNo, row, subGrid);
             });*/
        }
    });

    /** *****************************点击事件和函数************************************** */
    function _animal_genotype_setAddForm(rowData, openerGrid) {
        parent.$.modalDialog({
            title: '添加动物-基因型',
            width: 350,
            height: 250,
            href: getContentPath() + '/rp/toAddGenPage.do?animalId=' + rowData.id,
            buttons: [
                {
                    text: '确定',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = openerGrid;
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

    function _animal_genotype_remove(codeA, codeB, primerNo, rowData, openerGrid) {
        var rows = $(openerGrid).datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.codeA + ":" + row.codeB + ":" + row.primerNo;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，确定要删除所选的动物基因型？", function () {
                $.ajax({
                    url: getContentPath() + "/rp/deleteGens.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        id: rowData.id,
                        "ids": ids
                    },
                    beforeSend: function (jqXHR, settings) {
                        Dialog.fullprogress.open('删除中，请稍候...', "操作");
                    },
                    complete: function (jqXHR, textStatus) {
                        Dialog.fullprogress.close();
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data.type == "error") {
                            Dialog.error(data.msg, "错误");
                        } else {
                            _animal_genotype_reloadDataGrid(codeA, codeB, primerNo, rowData, openerGrid);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的动物基因型！", "警告");
        }
    }

    function _animal_genotype_reloadDataGrid(codeA, codeB, primerNo, row, openerGrid) {
        $(openerGrid).datagrid("load", {
            "animalId": row.id,
            "primerNo": primerNo,
            "codeA": codeA,
            "codeB": codeB
        });
        $(openerGrid).datagrid("uncheckAll");
    }

    /**
     * 查询按钮点击事件
     */
    $("#genotype-animal-search").click(function () {
        _red_panda_reloadDataGrid();
    });

    function _red_panda_reloadDataGrid() {
        $('#genotype-animal-table').datagrid("load", {
            "microchipCode": $("#genotype-animal-chipNo").val(),
            "no" : $('#genotype-animal-no').val(),
            "queryGenotypes": false
        });
        $('#genotype-animal-table').datagrid("uncheckAll");
    }

    /**
     * 对比功能
     */
    $('#ag-compare').click(function () {
        var rows = $('#genotype-animal-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");
        // 至少选择两个动物
        if (ids != '' && rows.length >= 2) {
            addTab({
                title: "动物基因型对比",
                iconCls: 'icon-exam',
                url: getContentPath() + "/ag/cp/init.do?ids=" + ids
            }, true);
        } else {
            Dialog.warning('请选择至少两只需要对比基因型的动物！', '警告');
        }
    });
});