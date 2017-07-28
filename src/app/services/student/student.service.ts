﻿import { Injectable } from '@angular/core';
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
}