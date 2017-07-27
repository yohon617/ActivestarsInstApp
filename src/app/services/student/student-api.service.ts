import { Injectable } from '@angular/core';
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
}