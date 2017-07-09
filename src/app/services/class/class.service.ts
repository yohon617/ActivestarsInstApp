import { Injectable } from '@angular/core';
import { Headers, Http }       from '@angular/http';


import 'rxjs/add/operator/toPromise';

import { ClassAPIService } from './class-api.service';

import { Class }           from './../../models/class';

@Injectable()
export class ClassService {
      
  private headers = new Headers({ 'Content-Type': 'application/json' });
  private selectedClass: Class

  constructor(private http: Http, private classAPIService: ClassAPIService) {}

  getClasses(): Promise<Class[]> {
      return this.classAPIService.getClasses()
          .then(classes => {
              this.selectedClass = classes[0];
              return classes;
          });
  }

  get SelectedClass():Class {
        return this.selectedClass;
  }

  set SelectedClass(value: Class) {
      this.selectedClass = value;
  }

 
}
