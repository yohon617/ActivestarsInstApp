import { Injectable } from '@angular/core';
import { Headers, Http }       from '@angular/http';


import 'rxjs/add/operator/toPromise';

import { ClassAPIService } from './class-api.service';

import { Class }           from './../../models/class';
import { ClassWeek }           from './../../models/classWeek';

@Injectable()
export class ClassService {
      
  private headers = new Headers({ 'Content-Type': 'application/json' });
  private selectedClass: Class;
  private selectedClassWeeks: ClassWeek[]
  private selectedWeek: ClassWeek;

  constructor(private http: Http, private classAPIService: ClassAPIService) {}

  getClasses(): Promise<Class[]> {
      return this.classAPIService.getClasses()
          .then(classes => {
              this.selectedClass = classes[0];
              this.getNewClassWeeks();
              return classes;
          });
  }

  classSelectedChange(changedClass: Class) {
      this.selectedClass = changedClass;
      this.getNewClassWeeks();
  }

  getNewClassWeeks() {
      this.classAPIService.getClassWeeks(this.selectedClass.ID)
          .then(weeks => {
              this.selectedClassWeeks = weeks;
              for (let week of this.selectedClassWeeks) {
                  console.log(Date.now());
                  console.log(new Date(week.ClassDate));
                  if (week.WeekNumber == this.selectedClass.NumOfWeeks) {
                      this.selectedWeek = week;
                  }
                  else if (new Date().getTime() < new Date(week.ClassDate).getTime()) {
                      this.selectedWeek = week;
                      break;
                  }

              }
          });
  }

  postTest(): Promise<string> {
      return this.classAPIService.postTest()
          .then(result => result);
  }

  uploadFile(files: File[]) {
      return this.classAPIService.uploadFile(files);
  }

  get SelectedClass():Class {
        return this.selectedClass;
  }

  set SelectedClass(value: Class) {
      this.selectedClass = value;
  }

  get SelectedClassWeeks(): ClassWeek[] {
      return this.selectedClassWeeks;
  }

  get SelectedClassWeek(): ClassWeek {
      return this.selectedWeek;
  }

  set SelectedClassWeek(value: ClassWeek) {
      this.selectedWeek = value;
  }

 
}
