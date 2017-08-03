﻿import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http } from '@angular/http';

import { ConfigService } from './../../config/config.service';

import { Observable } from 'rxjs/Rx';
import 'rxjs/add/operator/toPromise';


import { StudentSearchResult } from './../../models/studentSearchResult';
import { Student } from './../../models/student';
import { StudentRoster } from './../../models/studentRoster';

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

    CheckInStudent(studentID, classReportID, payType, specialClassFee, makeupWeeks): void {
        this.http.post(this.config.get("apiURL") + "/api/students.mvc/CheckInStudent?studentID=" + studentID + "&classReportID=" + classReportID
            + "&payType=" + payType + "&specialClassFee=" + specialClassFee + "&makeupWeeks=" + makeupWeeks
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json());
    }
}