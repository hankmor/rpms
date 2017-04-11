//~===================================== 系统常量定义 =====================================
/**
 * 小熊猫
 * @type {{STATUS_DELETE: number, STATUS_TRANS_OUT: number, STATUS_FEEDING: number}}
 */
var RED_PANDA = {
    /**
     * 被删除
     */
    STATUS_DELETE: -1,
    /**
     * 已经转出
     */
    STATUS_TRANS_OUT: 0,
    /**
     * 在养状态
     */
    STATUS_FEEDING: 1,
    /**
     * 死亡
     */
    STATUS_DEAD: -2
};

/**
 * 性别
 * @type {{MALE: number, FEMALE: number}}
 */
var SEX = {
    MALE: true, FEMALE: false
}

/**
 * 用户
 * @type {{STATUS_DELETE: number, STATUS_ENABLE: number, STATUS_NOT_ENABLE: number}}
 */
var USER = {
    STATUS_DELETE: -1,
    STATUS_ENABLE: 1,
    STATUS_NOT_ENABLE: 0
}

/**
 * 圈舍转移类型
 * @type {{TRANS_OUT_TO_OTHER_ZOO: number, TRANS_OUT_TO_LOCAL_HOUSE: number, TRANS_IN_FROM_OTHER_ZOO: number, TRANS_IN_FROM_LOCAL_ZOO: number}}
 */
var HOUSE_TRANSFER_TYPE = {
    /**
     * 转出到外部园区
     */
    TRANS_OUT_TO_OTHER_ZOO: 0,
    /**
     * 转出到本园区
     */
    TRANS_OUT_TO_LOCAL_HOUSE: 1,
    /**
     * 从外部园区转入
     */
    TRANS_IN_FROM_OTHER_ZOO: 2,
    /**
     * 从本园区转入
     */
    TRANS_IN_FROM_LOCAL_ZOO: 3
}

//工具方法
function getContentPath() {
    if (ctx == undefined) {
        var pathName = document.location.pathname;
        var index = pathName.substr(1).indexOf("/");
        var path = pathName.substr(0, index + 1);
        return path;
    } else return ctx;
}

//~===================================== 弹出对话框 =====================================
var Dialog = {};

/**
 * 简单对话框，无图标
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 回调函数
 * @constructor
 */
Dialog.alert = function alert(msg, title, callback) {
    var t = title || "Alert";
    var m = msg || "Here is a alert message!";
    $.messager.alert(t, m, '', callback);
}

/**
 * 错误对话框，带错误图标
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 回调函数
 * @constructor
 */
Dialog.error = function error(msg, title, callback) {
    var t = title || "Error";
    var m = msg || "Here is a error message!";
    $.messager.alert(t, m, 'error', callback);
}

/**
 * 信息框，带信息图标
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 回调函数
 * @constructor
 */
Dialog.info = function information(msg, title, callback) {
    var t = title || "Information";
    var m = msg || "Here is a information message!";
    $.messager.alert(t, m, 'info', callback);
}
/**
 * 疑问对话框，问疑问图标
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 回调函数
 * @constructor
 */
Dialog.question = function question(msg, title, callback) {
    var t = title || "Question";
    var m = msg || "Here is a question message!";
    $.messager.alert(t, m, 'question', callback);
}
/**
 * 警告对话框，带警告图标
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 回调函数
 * @constructor
 */
Dialog.warning = function warning(msg, title, callback) {
    var t = title || "Warning";
    var m = msg || "Here is a warning message!";
    $.messager.alert(t, m, 'warning', callback);
}
/**
 * 确认对话框
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 点击确定后的回调函数
 * @constructor
 */
Dialog.confirm = function confirm(msg, callback, title) {
    var t = title || "Confirm";
    var m = msg || "Here is a confirm message!";
    $.messager.confirm(t, m, function (r) {
        if (r) {
            callback.call(this);
        }
    });
}
/**
 * 输入对话框
 *
 * @author Dendy
 * @since 2014-1-18 11:42:35
 * @param title 标题
 * @param msg 信息
 * @param callback 点击确定后的回调函数，参数为输入的值
 * @constructor
 */
Dialog.prompt = function prompt(msg, callback, title) {
    var t = title || "Prompt";
    var m = msg || "Please type something";
    $.messager.prompt(t, m, function (r) {
        if (r) {
            callback.call(this, r);
        }
    });
}

/**
 * 进度对话框
 *
 * @param title 标题
 * @param msg 显示信息
 * @param timeout 自动关闭时间
 */
Dialog.progress = function progress(msg, timeout, title) {
    var t = title || "Please waiting";
    var m = msg || "Loading data...";
    var time = timeout || 3000;
    var win = $.messager.progress({
        title: t,
        msg: m
    });
    setTimeout(function () {
        $.messager.progress('close');
    }, time)
}

Dialog.progress.open = function progress(msg, title) {
    var t = title || "Please waiting";
    var m = msg || "Loading data...";
    $.messager.progress({ title: t, msg: m });
}

Dialog.progress.close = function progress() {
    $.messager.progress('close');
}

/**
 * 操作等待对话框
 *
 * @param title 标题
 * @param msg 显示信息
 * @param timeout 自动关闭时间
 */
Dialog.fullprogress = function fullprogress(msg, timeout, title) {
    var t = title || "Please waiting";
    var m = msg || "Loading data...";
    var time = timeout || 3000;
    var win = $.messager.fullprogress({
        title: t,
        msg: m
    });
    setTimeout(function () {
        $.messager.fullprogress('close');
    }, time)
}

Dialog.fullprogress.open = function fullprogress(msg, title) {
    var t = title || "Please waiting";
    var m = msg || "Loading data...";
    $.messager.fullprogress({ title: t, msg: m });
}

Dialog.fullprogress.close = function fullprogress() {
    $.messager.fullprogress('close');
}

/**
 * 根据后台message对象弹出对应对话框
 *
 * @author Dendy
 * @since 2014-1-18 11:52:16
 * @param message 后台传递的BaseMessage对象
 * @param callback 回调
 * @param msg 自定义提示信息，不传递该参数，则使用message对象本身的
 */
function dialog(message, callback, msg) {
    if (!message || !message.type)
        return;
    if (!msg && !message.msg)
        return;
    var type = message.type;
    switch (type) {
        case "info":
            Dialog.info(msg || message.msg, "信息", callback);
            break;
        case "warn":
            Dialog.warning(msg || message.msg, "警告", callback);
            break;
        case "error":
            Dialog.error(msg || message.msg, "错误", callback);
            break;
        case "success":
            Dialog.info(msg || message.msg, "信息", callback);
            break;
        default:
            return;
    }
}

//~===================================== 页面消息框 =====================================

var MessageBox = {};
/**
 * 消息盒子出现的位置
 * @type {{}}
 */
MessageBox.position = {};
MessageBox.position.TOP_LEFT = 0;
MessageBox.position.TOP_CENTER = 1;
MessageBox.position.TOP_RIGHT = 2;
MessageBox.position.CENTER_LEFT = 3;
MessageBox.position.CENTER = 4;
MessageBox.position.CENTER_RIGHT = 5;
MessageBox.position.BOTTOM_LEFT = 6;
MessageBox.position.BOTTOM_CENTER = 7;
MessageBox.position.BOTTOM_RIGHT = 8;
/**
 * 消息盒动画显示类型
 * @type {{}}
 */
MessageBox.showType = {};
MessageBox.showType.FADE = "fade";
MessageBox.showType.SHOW = "show";
MessageBox.showType.SLIDE = "slide";
/**
 * 弹出页面消息盒
 *
 * @author Dendy
 * @since 2014-1-18 14:00:50
 * @param msg 消息信息
 * @param timeout 消息盒消失时间，单位毫秒.
 * @param title 消息盒标题
 * @param showType 动画类型，见MessageBox.showType
 * @param pos 消息盒出现的位置，见MessageBox.position
 */
MessageBox.message = function message(msg, timeout, title, showType, pos) {
    var t = title || "Message";
    var m = msg || "The message content";
    var s = showType || "show";
    var time = timeout || 3000;
    // 默认位置为右下
    var p = { left: '', right: 0, top: '', bottom: -document.body.scrollTop - document.documentElement.scrollTop};
    if (pos != "undefined") {
        if (pos === this.position.TOP_LEFT)
            p = { right: '', left: 0, top: document.body.scrollTop + document.documentElement.scrollTop, bottom: '' };
        else if (pos === this.position.TOP_CENTER)
            p = { right: '', top: document.body.scrollTop + document.documentElement.scrollTop, bottom: ''};
        else if (pos === this.position.TOP_RIGHT)
            p = { left: '', right: 0, top: document.body.scrollTop + document.documentElement.scrollTop, bottom: ''};
        else if (pos === this.position.CENTER_LEFT)
            p = { left: 0, right: '', bottom: '' };
        else if (pos === this.position.CENTER)
            p = { right: '', bottom: '' };
        else if (pos === this.position.CENTER_RIGHT)
            p = { left: '', right: 0, bottom: ''};
        else if (pos === this.position.BOTTOM_LEFT)
            p = { left: 0, right: '', top: '', bottom: -document.body.scrollTop - document.documentElement.scrollTop};
        else if (pos === this.position.BOTTOM_CENTER)
            p = { right: '', top: '', bottom: -document.body.scrollTop - document.documentElement.scrollTop};
    }
    $.messager.show({
        title: t,
        msg: m,
        showType: s,
        style: p,
        timeout: time
    });
}

/**
 * 测试方法，仅供使用测试用.
 *
 * @author Dendy
 * @since 2014-1-18 13:59:54
 * @private
 */
MessageBox.test = function _testMessage() {
    setTimeout(function () {
        MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SLIDE, MessageBox.position.TOP_LEFT);
        setTimeout(function () {
            MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.FADE, MessageBox.position.TOP_CENTER);
            setTimeout(function () {
                MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SHOW, MessageBox.position.TOP_RIGHT);
                setTimeout(function () {
                    MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SLIDE, MessageBox.position.CENTER_LEFT);
                    setTimeout(function () {
                        MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.FADE, MessageBox.position.CENTER);
                        setTimeout(function () {
                            MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SHOW, MessageBox.position.CENTER_RIGHT);
                            setTimeout(function () {
                                MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SLIDE, MessageBox.position.BOTTOM_LEFT);
                                setTimeout(function () {
                                    MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.FADE, MessageBox.position.BOTTOM_CENTER);
                                    setTimeout(function () {
                                        MessageBox.message("您有新的消息", 15000, "消息", MessageBox.showType.SHOW, MessageBox.position.BOTTOM_RIGHT);
                                    }, 2000);
                                }, 2000);
                            }, 2000);
                        }, 2000);
                    }, 2000);
                }, 2000);
            }, 2000);
        }, 2000);
    }, 2000);
}

//~===================================== ajax封装 =====================================
/**
 * 异步请求
 *
 * @author Dendy
 * @since 2013-10-29 16:48:01
 * @param url 请求url
 * @param args 请求参数
 * @param successCallback 成功后回调
 * @param erroCallback 错误后回调
 * @param tipMsg 加载框提示信息
 * @param async 是否异步请求，默认为true
 * @param showLoading 是否显示加载对话框,默认不显示
 */
function ajax(url, args, successCallback, erroCallback, tipMsg, async, showLoading) {
    if (!url) {
        Dialog.error("url地址不能为空！", "错误", null);
        return;
    }

    if (showLoading) {
        var msg = tipMsg || "加载中……";
        Dialog.progress.open("请稍后", msg);
    }

    if (async == undefined || async == null || async === '') {
        async = true;
    }

    var self = this;
    $.ajax({
        url: url,
        dataType: "json",
        type: "post",
        data: args || {},
        async: async,
        success: function (data) {
            try {
                successCallback.call(self, data);
            } catch (e) {
//				console.log(e);
            }
        },
        error: function (data) {
            try {
                erroCallback.call(self, data);
            } catch (e) {
//				console.log(e);
            }
        },
        complete: function (xhr, textstatus) {
            if (showLoading)
                Dialog.progress.close();
        }
    });
}

/**
 * 异步提交表单
 *
 * @param form 提交的表单-dom对象
 * @param successCallback 提交成功回调
 * @param errorCallback 提交失败回调
 * @param showLoading 是否显示加载动画
 * @param tipMsg 加载动画提示信息，如"保存", "提交".
 */
function ajaxSubmitForm(form, successCallback, errorCallback, showLoading, tipMsg) {
    if (!form) {
        Dialog.error("目标form不能为空！", "错误", null);
        return;
    }
    if (showLoading) {
        var msg = tipMsg || "表单提交中……";
        Dialog.progress.open("请稍后", msg);
    }

    var self = this;
    $(form).ajaxSubmit({
        dataType: 'json',
        success: function (data) {
            try {
                successCallback.call(self, data);
            } catch (e) {
//				console.log(e);
            }
        }, error: function (data) {
            try {
                errorCallback.call(self, data);
            } catch (e) {
//				console.log(e);
            }
        }, complete: function () {
            if (showLoading)
                Dialog.progress.close();
        }
    });
}

/**
 * @author  Dendy
 *
 * @requires jQuery,EasyUI
 *
 * 创建一个模式化的dialog
 *
 * @returns $.modalDialog.handler 这个handler代表弹出的dialog句柄
 *
 * @returns $.modalDialog.xxx 这个xxx是可以自己定义名称，主要用在弹窗关闭时，刷新某些对象的操作，可以将xxx这个对象预定义好
 */
$.modalDialog = function (options) {
//    if ($.modalDialog.handler == undefined) {// 避免重复弹出
    var opts = $.extend({
        title: '',
        width: 840,
        height: 680,
        modal: true,
        onClose: function () {
            $.modalDialog.handler = undefined;
            $(this).dialog('destroy');
        },
        onOpen: function () {
            parent.$.messager.progress({
                title: '提示',
                text: '数据处理中，请稍后....'
            });
        }
    }, options);
    opts.modal = true;// 强制此dialog为模式化，无视传递过来的modal参数
    return $.modalDialog.handler = $('<div/>').dialog(opts);
//    }
};

//~===================================== esayui验证规则扩展 =====================================
$.extend($.fn.validatebox.defaults.rules, {
    /**
     * 两次输入的值相等
     */
    equals: {
        validator: function (value, param) {
            return value == $(param[0]).val();
        },
        message: '两次输入的值不一致.'
    },
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '该字段至少需要输入{0}个字符.'
    },
    maxLength: {
        validator: function (value, param) {
            return value.length <= param[0];
        },
        message: '该字段最大只能输入{0}个字符.'
    },
    selected: {
        /**
         * 下拉框必须选择，且选择的option的value属性必须有值
         *
         * @param value 选择的option的value值，如果option的value为空，则返回选择文本
         * @param param 数组，仅有一个元素，传递当前select的选择器，如#sel.
         * @returns {boolean}
         */
        validator: function (value, param) {
            var selValue = $(param[0] + " option:selected").attr('value');
            return selValue != "" && selValue != null && selValue != undefined;
        },
        message: '必须选择一个选项.'
    },
    // 全部为字母
    word: {
        validator: function (value, param) {
            var charRegex = /^([a-zA-Z]+)$/;
            return charRegex.test(value);
        },
        message: '输入的内容必须为字母.'
    },
    // 全部为数字
    digit: {
        validator: function (value, param) {
            var digitRegex = /^([0-9]+)$/;
            return digitRegex.test(value);
        },
        message: '输入的内容必须为数字.'
    },
    // 小树
    number: {
        validator: function (value, param) {
            var digitRegex = /^([0-9]+\.?[0-9].)$/;
            return digitRegex.test(value);
        },
        message: '必须为小数或整数.'
    },
    // 内容全部为中文
    chinese: {
        validator: function (value, param) {
            var chinese = /^[\u4e00-\u9fa5]+$/;
            return chinese.test(value);
        },
        message: '输入的内容必须为中文字符.'
    },
    // 简单字符：字母数字下划线
    simpleString: {
        validator: function (value, param) {
            var simpleRegex = /^\w+$/;
            return simpleRegex.test(value);
        },
        message: '输入的内容必须为字符、数字、下划线的组合.'
    },
    suffix: {
        /**
         * 文件后缀验证规则.
         *
         * @param value
         * @param param 支持的后缀列表，逗号分割，如.PDF,.DOC,.xls
         * @returns {boolean}
         */
        validator: function (value, param) {
            var suffixStr = param[0].trim().toLowerCase();
            var n = value.trim().lastIndexOf(".");
            var fileSuffix = value.substr(n).toLowerCase();
            return suffixStr.indexOf(fileSuffix) > -1;
        },
        message: '不支持的文件类型.'
    },
    // 用户名验证规则:字母数字下划线且首字符只能为字母
    username: {
        validator: function (value, param) {
            var usernameRegex = /^[a-zA-Z]\w*$/;
            return usernameRegex.test(value);
        },
        message: '输入的内容必须为字母、数字、下划线的组合且首字符必须为字母.'
    },
    // 是填空题，必须包含"_"
    isBlankTopic: {
        validator: function (value, param) {
            return value.indexOf("_") > -1;
        },
        message: '填空题必须包含可填项，请输入"_"表示可填项.'
    },
    sameNo: {
        validator: function (value, param) {
            var url = param[0];
            var p = param[1];
            var args = {
                "no": value
            };
            // 支持传递多个参数，形式：pName1 : pValue1 , pName2 : pValue2
            if (p) {
                var ps = p.split(',');
                for (var i = 0; i < ps.length; i++) {
                    var pm = ps[i];
                    var pms = pm.split(':');
                    args[pms[0]] = pms[1];
                }
            }
            var result = $.ajax({
                url: getContentPath() + url,
                dataType: "json",
                data: args,
                type: "post",
                async: false
            });
            return result.responseText == "true" ? false : true;
        },
        message: '已有重复的编码'
    },
    sameUserName: {
        validator: function (value, param) {
            var url = param[0];
            var result = $.ajax({
                url: getContentPath() + url,
                dataType: "json",
                data: {
                    "username": value
                },
                type: "post",
                async: false
            });
            return result.responseText == "true" ? false : true;
        },
        message: '已有重复的用户名'
    }
});

/**
 * 去空白
 * @param str
 * @return
 */
function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, '');
}

/**
 * String replaceAll
 * @param s1
 * @param s2
 * @returns {string}
 */
String.prototype.replaceAll = function (s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2); //g全局
}

/**
 * 格式化String
 * 例如:
 *   var str = "a={0},b={1}";
 *   var a = aa;
 *   var b = bb;
 *   str.format(a, b);
 *   输出：a=aa,b=bb
 * @returns {string}
 */
String.prototype.format = function () {
    var args = arguments;
    return this.replace(/\{(\d+)\}/g,
        function (m, i) {
            return args[i];
        });
}

/**
 * 播放mp3，播放器隐藏
 * @param placeHoleId 放置mp3播放器的div的ID
 * @param src 要播放的mp3的网络地址
 */
function media_play_hidden(placeHoleId, src) {
    $("#" + placeHoleId).jmp3({
        "playerpath": getContentPath() + "/assets/mp3player/",
        "fileurl": src,
        "width": "0",
        "height": "0",
        "volume": "100",
        "autoplay": "true",
        "showdownload": "false",
        "showfilename": "false"
    });
}

/**
 * 播放mp3，播放器不隐藏
 * @param placeHoleId 放置mp3播放器的div的ID
 * @param src 要播放的mp3的网络地址
 * @param width 播放器宽度，默认150
 */
function media_play_show(placeHoleId, src, width) {
    if (width == '' || width == null) {
        width = "150";
    }
    $("#" + placeHoleId).jmp3({
        "playerpath": getContentPath() + "/assets/mp3player/",
        "fileurl": src,
        "width": width,
        "height": "20",
        "volume": "100",
        "autoplay": "false",
        "showdownload": "false",
        "showfilename": "false",
        "forecolor": "000000"
    });
}

/**
 * 获取播放mp3的HTML
 * @param src 要播放的mp3的网络地址
 * @param width 播放器宽度，默认150
 */
function getMp3playerHTML(src, width) {
    if (width == '' || width == null) {
        width = "150";
    }
    var playerpath = getContentPath() + "/assets/mp3player/";
    var mp3html = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" ';
    mp3html += 'width="' + width + '" height="20" ';
    mp3html += 'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">';
    mp3html += '<param name="movie" value="' + playerpath + 'singlemp3player.swf?';
    mp3html += 'showDownload=false&file=' + src + '&autoStart=false';
    mp3html += '&frontColor=000000';
    mp3html += '&repeatPlay=no&songVolume=100" />';
    mp3html += '<param name="wmode" value="transparent" />';
    mp3html += '<embed wmode="transparent" width="' + width + '" height="20" ';
    mp3html += 'src="' + playerpath + 'singlemp3player.swf?';
    mp3html += 'showDownload=false&file=' + src + '&autoStart=false';
    mp3html += '&frontColor=000000';
    mp3html += '&repeatPlay=no&songVolume=100" ';
    mp3html += 'type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
    mp3html += '</object>';

    return mp3html;
}

String.prototype.startWith = function (str) {
    var reg = new RegExp("^" + str);
    return reg.test(this);
}

String.prototype.endWith = function (str) {
    var reg = new RegExp(str + "$");
    return reg.test(this);
}

Number.prototype.toLowerCase = function () {
    return (this + "").toLowerCase();
}

Number.prototype.indexOf = function (searchString) {
    return (this + "").indexOf(searchString);
}