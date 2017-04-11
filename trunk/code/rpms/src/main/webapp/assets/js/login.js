$(function () {
    /**
     * 定位登录区域
     */
    var windowHeight = $(window).height();
    var wrapHeight = $("#wrap").height();
    if (windowHeight > 640) {
        var marginTop = (parseInt(windowHeight) - 640) / 4;
        var paddingBottom = 640 - parseInt(wrapHeight);
        $("#wrap").css("margin-top", marginTop + "px").css("padding-bottom", paddingBottom + "px");
    } else if (parseInt(windowHeight) - parseInt(wrapHeight) > 0) {
        var paddingBottom = parseInt(windowHeight) - parseInt(wrapHeight);
        $("#wrap").css("padding-bottom", paddingBottom + "px");
    } else {
        var loginAreaDivWidth = $("#login-role").parent("div").width();
        $("#login-role").parent("div").width(parseInt(loginAreaDivWidth) + 20);
        $("#wrap").css("padding-bottom", "2px").css("width", "1346px");
    }

    /**
     * 角色选择点击公共事件
     */
    $(".role-tab").click(function () {
        $(".role-tab").removeClass("role-tab-choose");
        $(this).addClass("role-tab-choose");
    });

    /**
     * 学生角色选择点击事件
     */
    $("#student-tab").click(function () {
        $(".teacher-img").removeClass("teacher-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".manager-img").removeClass("manager-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".student-img").addClass("student-img-choose").next().addClass("role-font-choose").parent(".role-img").next().show();
        $("#manager-form").hide();
        $("#teacher-form").hide();
        $("#login-title").text("学生登录");
        $("#student-form").show();

    });

    /**
     * 教师角色选择点击事件
     */
    $("#teacher-tab").click(function () {
        $(".student-img").removeClass("student-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".manager-img").removeClass("manager-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".teacher-img").addClass("teacher-img-choose").next().addClass("role-font-choose").parent(".role-img").next().show();
        $("#manager-form").hide();
        $("#student-form").hide();
        $("#login-title").text("教师登录");
        $("#teacher-form").show();
    });

    /**
     * 管理员角色选择点击事件
     */
    $("#manager-tab").click(function () {
        $(".teacher-img").removeClass("teacher-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".student-img").removeClass("student-img-choose").next().removeClass("role-font-choose").parent(".role-img").next().hide();
        $(".manager-img").addClass("manager-img-choose").next().addClass("role-font-choose").parent(".role-img").next().show();
        $("#student-form").hide();
        $("#teacher-form").hide();
        $("#login-title").text("管理员登录");
        $("#manager-form").show();
    });

    /**
     * 登录按钮点击事件
     */
    $(".login-button").click(function () {
//        $(this).parents("form")[0].submit();
        var fm = $(this).parents("form")[0];
        if ($(fm).attr("id") == "student-form") {
            if (browser.isIe == false) {
                alert("本系统仅支持IE浏览器，请更换为IE浏览器再使用！");
            } else
                fm.submit();
        } else
            fm.submit();
    });
});