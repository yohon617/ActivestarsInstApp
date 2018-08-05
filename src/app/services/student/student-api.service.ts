import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http } from '@angular/http';

import { ConfigService } from './../../config/config.service';

import { Observable } from 'rxjs/Rx';
import 'rxjs/add/operator/toPromise';


import { StudentSearchResult } from './../../models/studentSearchResult';
import { Student } from './../../models/student';
import { StudentRoster } from './../../models/studentRoster';
import { School } from './../../models/school';

@Injectable()
export class StudentAPIService {
    
    constructor(private http: Http, private config: ConfigService) { }
    
    getStudentRosters(classReportID): Promise<StudentRoster[]> {
        return this.http.get(this.config.get("apiURL") + "/api/students.mvc/GetStudentRosters?classReportID=" + classReportID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as StudentRoster[])
        //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
    }

    searchStudent(firstName: string, lastName: string, aCode: string, fCode: string, sCode: string) {
        return this.http.get(`${this.config.get('apiURL')}/api/Students.mvc/SearchStudents?firstName=${firstName}&lastName=${lastName}&aCode=${aCode}&fCode=${fCode}&sCode=${sCode}`, this.config.requestOptions)
            .toPromise()
            .then(response => response.json(), error => console.log(error));
    }

    getStudent(studentID, classReportID): Promise<Student> {
        return this.http.get(this.config.get("apiURL") + "/api/students.mvc/GetStudent?studentID=" + studentID + "&classReportID=" + classReportID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as Student)
    }

    getStudentRosterABWeeks(studentID, classReportID): Promise<string> {
        return this.http.get(this.config.get("apiURL") + "/api/students.mvc/GetStudentRosterABWeeks?studentID=" + studentID + "&classReportID=" + classReportID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as string)
    }

    getStudentRosterMadeUpWeeks(studentID, classReportID): Promise<string> {
        return this.http.get(this.config.get("apiURL") + "/api/students.mvc/GetStudentRosterMadeUpWeeks?studentID=" + studentID + "&classReportID=" + classReportID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as string)
    }

    getStudentPIFWeeks(classReportID, studentID): Promise<number> {
        return this.http.get(this.config.get("apiURL") + "/api/students.mvc/GetStudentPIFWeeks?classReportID=" + classReportID + "&studentID=" + studentID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as number)
    }

    CheckInStudent(studentID, classReportID, payType, specialClassFee, classFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, prepaidFee, specialtyClasses) {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/CheckInStudent?studentID=" + studentID + "&classReportID=" + classReportID
            + "&payType=" + payType + "&specialClassFee=" + specialClassFee + "&classFee=" + classFee + "&makeupWeeks=" + makeupWeeks + "&cashFee=" + cashFee
            + "&creditFee=" + creditFee+ "&checkFee=" + checkFee + "&voucherFee=" + voucherFee + "&testChecked=" + testChecked + "&prepaidFee=" + prepaidFee
            + "&specialtyClasses=" + specialtyClasses
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json());
    }

    UpdateCheckInStudent(studentID, classReportID, payType, specialClassFee, makeupFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, specialtyClasses, madeUpWeekList) {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/UpdateCheckInStudent?studentID=" + studentID + "&classReportID=" + classReportID
            + "&payType=" + payType + "&specialClassFee=" + specialClassFee + "&makeupFee=" + makeupFee + "&makeupWeeks=" + makeupWeeks + "&cashFee=" + cashFee
            + "&creditFee=" + creditFee+ "&checkFee=" + checkFee + "&voucherFee=" + voucherFee + "&testChecked=" + testChecked
            + "&specialtyClasses=" + specialtyClasses+ "&madeupWeeks=" + madeUpWeekList
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json());
    }

    AddStudentToClass(studentID, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/AddStudentToClass?studentID=" + studentID + "&classReportID=" + classReportID
            + "&section=" + section + "&payType=" + payType + "&status=" + status + "&visiting=" + visiting + "&transfered=" + transfered
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as StudentRoster);
    }

    AddNewStudentToClass(student: Student, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/AddNewStudentToClass?classReportID=" + classReportID
            + "&section=" + section + "&payType=" + payType + "&status=" + status + "&visiting=" + visiting + "&transfered=" + transfered
            , JSON.stringify(student), this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as StudentRoster);
    }

    UpdateStudent(student: Student): Promise<any> {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/UpdateStudent"
            , JSON.stringify(student), this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as StudentRoster);
    }

    AddDropStudentRequest(studentID, classReportID, reason) {
        return this.http.post(this.config.get("apiURL") + "/api/students.mvc/AddDropRequest?studentID=" + studentID + "&classReportID=" + classReportID
            + "&reason=" + reason
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json())
            .catch(error => { console.log(error) });
    }

    getSchools(): Promise<School[]> {
        return this.http.get(this.config.get("apiURL") + "/api/schools.mvc/GetSchools", this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as School[])
    }
}
