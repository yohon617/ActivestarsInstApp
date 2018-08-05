import { Injectable } from '@angular/core';
import {  Http } from '@angular/http';


import 'rxjs/add/operator/toPromise';

import { StudentAPIService } from './student-api.service';

import { StudentSearchResult } from './../../models/studentSearchResult';
import { Student } from './../../models/student';
import { StudentRoster } from './../../models/studentRoster';
import { School } from './../../models/school';

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

    getStudentRosterMadeUpWeeks(studentID, classReportID): Promise<string> {
        return this.studentAPIService.getStudentRosterMadeUpWeeks(studentID, classReportID);
    }

    getStudentPIFWeeks(classReportID, studentID): Promise<number> {
        return this.studentAPIService.getStudentPIFWeeks(classReportID, studentID);
    }

    CheckInStudent(studentID, classReportID, payType, specialClassFee, classFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, prepaidFee, specialtyClasses) {
      return this.studentAPIService.CheckInStudent(studentID, classReportID, payType, specialClassFee, classFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, prepaidFee, specialtyClasses);
    }

    UpdateCheckInStudent(studentID, classReportID, payType, specialClassFee, makeupFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, specialtyClasses, madeUpWeekList) {
      return this.studentAPIService.UpdateCheckInStudent(studentID, classReportID, payType, specialClassFee, makeupFee, makeupWeeks, cashFee, creditFee, checkFee, voucherFee, testChecked, specialtyClasses, madeUpWeekList);
    }

    AddStudentToClass(studentID, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.studentAPIService.AddStudentToClass(studentID, classReportID, section, payType, status, visiting, transfered);
    }

    AddNewStudentToClass(student: Student, classReportID, section, payType, status, visiting, transfered): Promise<StudentRoster> {
        return this.studentAPIService.AddNewStudentToClass(student, classReportID, section, payType, status, visiting, transfered);
    }

    UpdateStudent(student: Student): Promise<any> {
        return this.studentAPIService.UpdateStudent(student);
    }

    AddDropStudentRequest(studentID, classReportID, reason) {
        return this.studentAPIService.AddDropStudentRequest(studentID, classReportID, reason);
    }

    getSchools(): Promise<School[]> {
        return this.studentAPIService.getSchools();
    }
}
