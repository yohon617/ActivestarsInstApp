import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http }       from '@angular/http';


import { Observable } from 'rxjs/Rx'; 
import 'rxjs/add/operator/toPromise';


import { Class }           from './../../models/class';

@Injectable()
export class ClassAPIService {
      
  private headers = new Headers({ 'Content-Type': 'application/json' });
  private headers2 = new Headers({  });
  private selectedClass: Class
  private testParam = { "ID": 999, "Name" : "rich y333u" }; 
    
    private config = new RequestOptions({
        "headers": this.headers
});

    private config2 = new RequestOptions({
        "headers": this.headers2
    });
  constructor(private http: Http) {}

  getClasses(): Promise<Class[]> {
      return this.http.get("http://api.activstarsonline.com/api/classes.mvc/GetClasses")
          .toPromise()
          .then(response => response.json() as Class[])
          //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

  postTest(): Promise<string> {
      console.log(JSON.stringify(this.testParam));
      return this.http.post("http://api.activstarsonline.com/api/classes.mvc/PostTest", JSON.stringify(this.testParam), this.config)
          .toPromise()
          .then(response => response.json().Name as string)
  }


  uploadFile(files: File[]) {
      let formData: FormData = new FormData();
      console.log(files[0].name);
      formData.append('uploadFile', files[0], files[0].name);
      this.http.post("http://api.activstarsonline.com/api/classes.mvc/UploadJsonFile", formData, this.config2)
          .catch(error => Observable.throw(error))
          .subscribe(
          data => console.log(data),
          error => console.log(error)
          )
      
  }
}
