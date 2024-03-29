package dendy.rpms.entity;

// Generated 2014-10-26 13:48:43 by Hibernate Tools 3.6.0

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * ExaminationAttaId generated by hbm2java
 */
@Embeddable
public class ExaminationAttaId implements java.io.Serializable {

	private long	examination;
	private long	atta;

	public ExaminationAttaId() {
	}

	public ExaminationAttaId(long examination, long atta) {
		this.examination = examination;
		this.atta = atta;
	}

	@Column(name = "EXAMINATION", nullable = false)
	public long getExamination() {
		return this.examination;
	}

	public void setExamination(long examination) {
		this.examination = examination;
	}

	@Column(name = "ATTA", nullable = false)
	public long getAtta() {
		return this.atta;
	}

	public void setAtta(long atta) {
		this.atta = atta;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ExaminationAttaId))
			return false;
		ExaminationAttaId castOther = (ExaminationAttaId) other;

		return (this.getExamination() == castOther.getExamination()) && (this.getAtta() == castOther.getAtta());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + (int) this.getExamination();
		result = 37 * result + (int) this.getAtta();
		return result;
	}

}
