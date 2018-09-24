import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Router } from '@angular/router';

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
        private studentService: StudentService,
        private router: Router
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

                this.router.navigate(['/roster']);
            });
    }


    addNewStudent() {
        let type: number = 0;
        if (this.searchType === 'transfer')
            type = 1;
        else if (this.searchType === 'visiting')
            type = 2;
        this.router.navigate(['/studentProfile', 0, type]);
    }

  getClassTeamName(classNumber) {
    switch (classNumber) {
      case 1:
        return this.classService.SelectedClass.TeamName1 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName1;
      case 2:
        return this.classService.SelectedClass.TeamName2 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName2;
      case 3:
        return this.classService.SelectedClass.TeamName3 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName3;
      case 4:
        return this.classService.SelectedClass.TeamName4 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName4;
      case 5:
        return this.classService.SelectedClass.TeamName5 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName5;
      case 6:
        return this.classService.SelectedClass.TeamName6 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName6;
      case 7:
        return this.classService.SelectedClass.TeamName7 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName7;
      case 8:
        return this.classService.SelectedClass.TeamName8 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName8;
      case 9:
        return this.classService.SelectedClass.TeamName9 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName9;
      case 10:
        return this.classService.SelectedClass.TeamName10 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName10;
      case 11:
        return this.classService.SelectedClass.TeamName11 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName11;
      case 12:
        return this.classService.SelectedClass.TeamName12 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName12;
      case 13:
        return this.classService.SelectedClass.TeamName13 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName13;
      case 14:
        return this.classService.SelectedClass.TeamName14 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName14;
      case 15:
        return this.classService.SelectedClass.TeamName15 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName15;
      case 16:
        return this.classService.SelectedClass.TeamName16 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName16;
      case 17:
        return this.classService.SelectedClass.TeamName17 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName17;
      case 18:
        return this.classService.SelectedClass.TeamName18 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName18;
      case 19:
        return this.classService.SelectedClass.TeamName19 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName19;
      case 20:
        return this.classService.SelectedClass.TeamName20 == "" ? "Class " + classNumber.toString() : this.classService.SelectedClass.TeamName20;
      default:
        return "Class " + classNumber.toString();
    }
  }
}
