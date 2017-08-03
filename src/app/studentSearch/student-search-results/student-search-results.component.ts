import { Component, OnInit, OnDestroy, Input } from '@angular/core';

import { ClassService } from './../../services/class/class.service';
import { StudentService } from './../../services/student/student.service';

import { Student } from './../../models/student';

@Component({
  selector: 'student-search-results',
  templateUrl: './student-search-results.component.html',
  styleUrls: ['./student-search-results.component.css']
})
export class StudentSearchResultsComponent implements OnInit, OnDestroy {

    @Input('studentList') studentList: Student[];
    @Input('searchType') searchType: string;

    private classReportID: any;
    private subscription: any;

    constructor(private classService: ClassService,
                private studentService: StudentService 
    ) {}

    ngOnInit() {
      this.subscription = this.classService.weekChange$.subscribe(() => this.initClassReportId());

      if (this.classReportID == null) {
        this.initClassReportId();
      }
    }

    ngOnDestroy() {
      this.subscription.unsubscribe();
    }

    private initClassReportId() {
        let selectedWeek = this.classService.SelectedClassWeek;
        if (selectedWeek) {
            console.log(selectedWeek);
            this.classReportID = selectedWeek.ClassReportID;
        }      
    }
    
    public addStudent(student: Student) {
        console.log(student);
        console.log(this.classReportID);
        let transfer = this.searchType === 'transfer';
        let visiting = this.searchType === 'visiting';
        this.studentService.AddStudentToClass(student.ID, this.classReportID, student.ClassNumber, student.PayType, student.Status, visiting, transfer)
            .then((response) => {
                console.log(response);
            });
    }




}
