import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http }       from '@angular/http';

import { ConfigService } from './../../config/config.service';

import { Observable } from 'rxjs/Rx'; 
import 'rxjs/add/operator/toPromise';


import { Class }           from './../../models/class';

@Injectable()
export class ClassAPIService {
      
  private selectedClass: Class
  private testParam = { "ID": 999, "Name" : "rich y33s3u", "angEx" : "testAngEx" }; 
    
    constructor(private http: Http, private config: ConfigService) {}

    getClasses(): Promise<Class[]> {
        return this.http.get(this.config.get("apiURL") + "/api/classes.mvc/GetClasses", this.config.requestOptions)
          .toPromise()
          .then(response => response.json() as Class[])
          //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  postTest(): Promise<string> {
      console.log(JSON.stringify(this.testParam));
      return this.http.post(this.config.get("apiURL") + "/api/classes.mvc/PostTest", JSON.stringify(this.testParam), this.config.requestOptions)
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
}
