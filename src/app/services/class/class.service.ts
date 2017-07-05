import { Injectable } from '@angular/core';
import { Headers, Http }       from '@angular/http';


import 'rxjs/add/operator/toPromise';


import { Class }           from './../../models/class';

@Injectable()
export class ClassService {
      
  private headers = new Headers({ 'Content-Type': 'application/json' });

  constructor(private http: Http) {}

      
  getClasses(): Promise<Class[]> {
      console.log("getClasses");
      return this.http.get("http://insttest.activstarsonline.com/Services/class/class.asp?cmd=getClasses")
          .toPromise()
          .then(response => response.json().Classes as Class[])
          //.then(response => console.log("response: ", response.json()), error => console.log("error: ", error));
  }

 
}
