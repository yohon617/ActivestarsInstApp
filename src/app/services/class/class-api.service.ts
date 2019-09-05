import { Injectable } from '@angular/core';
//import { RequestOptions, Headers, Http } from '@angular/http';
import { HttpClient, HttpHeaders, HttpParams, HttpResponse } from '@angular/common/http';

import { ConfigService } from './../../config/config.service';

import { Observable } from 'rxjs/Rx'; 
import 'rxjs/add/operator/toPromise';


import { Class } from './../../models/class';
import { ClassWeek } from './../../models/classWeek';
import { RPTClassSalesAndRetention } from './../../models/rptClassSalesAndRetention';
import { Http } from '@angular/http';

@Injectable()
export class ClassAPIService {
      
  private selectedClass: Class
  private testParam = { "ID": 999, "Name" : "rich y33s3u", "angEx" : "testAngEx" }; 
    
  constructor(private http: Http, private httpcc: HttpClient, private config: ConfigService) {}

  getClasses(): Promise<Class[]> {
    console.log(this.config.requestOptions);
    console.log(this.config.requestOptionsNew);
    return this.httpcc.get(this.config.get("apiURL") + "/api/classes.mvc/GetClasses", this.config.requestOptionsNew)
      .toPromise()
      .then(this.extractData)
      //.then(response => JSON.parse(String.fromCharCode.apply(null, new Uint8Array(response)))['message'] as Class[])
      //.then(response => console.log("response: ", response), error => console.log("error: ", error));
  }

  extractData(res: ArrayBuffer) {
    var array = new Array();
    var key, count = 0;
    for (key in res) {
      array.push(res[count++]);
    }
    return array;
  }

  getClassWeeks(classID): Promise<ClassWeek[]> {
      return this.http.get(this.config.get("apiURL") + "/api/classes.mvc/GetClassWeeks?classID=" + classID, this.config.requestOptions)
          .toPromise()
          .then(response => response.json() as ClassWeek[])
      //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  postTest(): Promise<string> {
      console.log(JSON.stringify(this.testParam));
      return this.http.post(this.config.get("apiURL") + "/api/classes.mvc/PostTest?id=ianchan&numnum=617", JSON.stringify(this.testParam), this.config.requestOptions)
          .toPromise()
          .then(response => response.json().Name as string)
  }


  uploadFile(files: File[]) {
      let formData: FormData = new FormData();
      console.log(files[0].name);
      formData.append('uploadFile', files[0], files[0].name);
      this.http.post(this.config.get("apiURL") + "/api/classes.mvc/UploadJsonFile", formData, this.config.requestOptionsNonJSON)
          .catch(error => Observable.throw(error))
          .subscribe(
          data => console.log(data),
          error => console.log(error)
          )
      
  }

  sendClassEmail(classID: number, subject: string, body: string): Promise<boolean> {
    let data = {
      "ClassID": classID,
      "Subject": subject,
      "Body": body
    };
    let sendBody = JSON.stringify(data)

    return this.http.post(this.config.get("apiURL") + "/api/classes.mvc/SendClassEmail", sendBody, this.config.requestOptions)
      .toPromise()
      .then(response => response.json() as boolean);

    //return new Promise(resolve => resolve(false));
    //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  sendStudentEmail(from: string, to: string, subject: string, body: string): Promise<boolean> {
    let data = {
      "From": from,
      "To": to,
      "Subject": subject,
      "Body": body
    };
    let sendBody = JSON.stringify(data)

    return this.http.post(this.config.get("apiURL") + "/api/classes.mvc/SendStudentEmail", sendBody, this.config.requestOptions)
      .toPromise()
      .then(response => response.json() as boolean);

    //return new Promise(resolve => resolve(false));
    //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  getInstructorEmail(): Promise<string> {
    return this.http.get(this.config.get("apiURL") + "/api/classes.mvc/GetInstructorEmail", this.config.requestOptions)
      .toPromise()
      .then(response => response.json() as string)
    //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  getClassSalesAndRententionReport(classID): Promise<RPTClassSalesAndRetention[]> {
    return this.http.get(this.config.get("apiURL") + "/api/classes.mvc/GetClassSalesAndRententionReport?classID=" + classID, this.config.requestOptions)
      .toPromise()
      .then(response => response.json() as RPTClassSalesAndRetention[])
    //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }
}
