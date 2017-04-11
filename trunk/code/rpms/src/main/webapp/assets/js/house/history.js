/**
 * 圈舍历史记录查询
 *
 * @author Dendy
 * @since 2014-8-29 16:41:37
 */

$(function () {
    parent.$.messager.progress('close');
    /**
     * 加载datagrid
     */
    $('#house-transfer-history-table').datagrid({
//        title: "转移历史记录",
        fitColumns: true,
        singleSelect: true,
        checkOnSelect: false,
        selectOnCheck: false,
        nowrap: true,
        pagination: false,
        rownumbers: true,
        fit: true,
        url: getContentPath() + '/ht/transRecords.do',
        queryParams: {
            "id": $('#house-transfer-table').datagrid('getSelected').id
        },
        columns: [
            [
                {field: 'animalChipCode', title: '芯片号', width: 80, align: 'center'},
                {field: 'from', title: '', width: 50, align: 'center', formatter: function (value, row, index) {
                    return "from";
                }},
                {field: 'src', title: '来源', width: 120, align: 'center'},
                {field: 'to', title: '', width: 50, align: 'center', formatter: function (value, row, index) {
                    return "to";
                }},
                {field: 'dest', title: '去向', width: 120, align: 'center'},
                {field: 'transType', title: '转移方式', width: 120, align: 'center', formatter: function (value, row, index) {
                    if (value == HOUSE_TRANSFER_TYPE.TRANS_IN_FROM_LOCAL_ZOO)
                        return "本园区新增";
                    else if (value == HOUSE_TRANSFER_TYPE.TRANS_IN_FROM_OTHER_ZOO)
                        return "从其他园区转入";
                    else if (value == HOUSE_TRANSFER_TYPE.TRANS_OUT_TO_LOCAL_HOUSE)
                        return "圈舍间转移";
                    else if (value == HOUSE_TRANSFER_TYPE.TRANS_OUT_TO_OTHER_ZOO)
                        return "转出到其他园区";
                }},
                { field: 'transTime', title: '转移时间', width: 100, align: 'center'},
//                { field: 'createTime', title: '记录时间', width: 100, align: 'center'},
                { field: 'remark', title: '备注', width: 150, align: 'center'}
            ]
        ]
    });
});