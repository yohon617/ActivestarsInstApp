import { Injectable } from '@angular/core';
import {  Http } from '@angular/http';


import 'rxjs/add/operator/toPromise';

import { StudentAPIService } from './student-api.service';

import { StudentSearchResult } from './../../models/studentSearchResult';
import { Student } from './../../models/student';
import { StudentRoster } from './../../models/studentRoster';

@Injectable()
export class StudentService {

    studentRosters: StudentRoster[]

    constructor(private http: Http, private studentAPIService: StudentAPIService) { }

    getStudentRosters(classReportID): Promise<StudentRoster[]> {
        return this.studentAPIService.getStudentRosters(classReportID);
    }

    searchStudent(firstName = '', lastName = '', aCode = '', fCode = '', sCode = ''): Promise<any> {
        return this.studentAPIService.searchStudent(firstName, lastName, aCode, fCode, sCode);
    }
    
    getStudent(studentID, classReportID): Promise<Student> {
        return this.studentAPIService.getStudent(studentID, classReportID);
    }

    getStudentRosterABWeeks(studentID, classReportID): Promise<string> {
        return this.studentAPIService.getStudentRosterABWeeks(studentID, classReportID);
    }

    CheckInStudent(studentID, classReportID, payType, specialClassFee, classFee, makeupWeeks) {
        return this.studentAPIService.CheckInStudent(studentID, classReportID, payType, specialClassFee, classFee, makeupWeeks);
    }

    AddStudentToClass(studentID, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.studentAPIService.AddStudentToClass(studentID, classReportID, section, payType, status, visiting, transfered);
    }

    AddNewStudentToClass(student: Student, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.studentAPIService.AddNewStudentToClass(student, classReportID, section, payType, status, visiting, transfered);
    }
}