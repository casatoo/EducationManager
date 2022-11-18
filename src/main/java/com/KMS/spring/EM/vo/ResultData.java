package com.KMS.spring.EM.vo;

import lombok.Getter;
import lombok.ToString;


@ToString
public class ResultData<DT> {
	
	@Getter
	private String resultCode;
	@Getter
	private String msg;
	@Getter
	private DT data1;
	@Getter
    private String data1Name;

	/**
	 * 보고서 형식 from
	 * 결과 코드와 메세지로 구성
	 * 오버로딩
	 * @param <DT>
	 * @param resultCode
	 * @param msg
	 * @return
	 */
	public static <DT> ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode, msg, null, null);
	}
	
	/**
	 * 보고서 형식 form
	 * 결과 코드, 메세지, 데이터명, 데이터 로 구성
	 * 오버로딩
	 * @param <DT>
	 * @param resultCode
	 * @param msg
	 * @param data1Name
	 * @param data1
	 * @return
	 */
	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name,DT data1) {
		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}
	/**
	 * S-로 시작되는 성공 여부 확인
	 * 코드가 S- 로 시작되면 = true
	 * @return
	 */
	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}
	
	/**
	 * 성공이 = false 라면 isFail = true
	 * @return
	 */
	public boolean isFail() {
		return isSuccess() == false;
	}
	
	/**
	 * 보고서를 담은 보고서 형식
	 * 보고서, 데이터명, 데이터로 구성
	 * 보고서코드, 보고서메세지, 데이터이름, 데이터 를 반환
	 * @param <DT>
	 * @param Rd
	 * @param data1Name
	 * @param data1
	 * @return
	 */
    public static <DT> ResultData<DT> newData(ResultData Rd, String data1Name, DT data1) {
        return from(Rd.getResultCode(), Rd.getMsg(), data1Name, data1);
    }
}
