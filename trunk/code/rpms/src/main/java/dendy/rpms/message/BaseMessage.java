package dendy.rpms.message;

/**
 * 系统通用消息类
 * 
 * @author Dendy
 * @since 2013-10-9下午5:18:36
 * @version 1.0
 */
public class BaseMessage {

	public static final String	QUERY_FAILED		= "Query Failed.";
	public static final String	QUERY_SUCCESS		= "Query Success.";
	public static final String	UPLOAD_FAILED		= "Upload File Failed.";
	public static final String	UPLOAD_SUCCESS		= "Upload File Success.";
	public static final String	DELETE_FAILED		= "Delete Failed.";
	public static final String	DELETE_SUCCESS		= "Delete Success.";
	public static final String	SAVE_SUCCESS		= "Save Success.";
	public static final String	SAVE_FAILED			= "Save Failed.";
	public static final String	UPDATE_FAILED		= "Update Failed.";
	public static final String	UPDATE_SUCCESS		= "Update Success.";
	public static final String	OPERATION_FAILED	= "Operation Failed.";
	public static final String	OPERATION_SUCCESS	= "Operation Successfully Completed.";

	// 消息内容
	private String				msg;
	// 消息类型
	private Type				type;

	public BaseMessage(Type type, String msg) {
		this.type = type;
		this.msg = msg;
	}

	/**
	 * info提示信息
	 * 
	 * @param msg
	 * @return
	 */
	public static BaseMessage infoMessage(String msg) {
		return new BaseMessage(Type.info, msg);
	}

	/**
	 * 警告提示信息
	 * 
	 * @param msg
	 * @return
	 */
	public static BaseMessage warnMessage(String msg) {
		return new BaseMessage(Type.warn, msg);
	}

	/**
	 * 错误提示信息
	 * 
	 * @param msg
	 * @return
	 */
	public static BaseMessage errorMessage(String msg) {
		return new BaseMessage(Type.error, msg);
	}

	/**
	 * 成功提示信息
	 * 
	 * @param msg
	 * @return
	 */
	public static BaseMessage successMessage(String msg) {
		return new BaseMessage(Type.success, msg);
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	/**
	 * 信息类型定义
	 * 
	 * @author Dendy
	 * @since 2013-10-10上午9:57:36
	 * @version 1.0
	 */
	public static enum Type {
		info, warn, error, success
	}
}
