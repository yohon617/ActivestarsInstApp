export class StudentRoster {
    StudentID: number;
    FirstName: string;
    LastName: string;
    Status: number; //1=Regular, 2=Advanced, 5=Extended
    PayType: string;
    ClassNumber: number;
    Visiting: boolean;
    Testing: boolean;
    Online: boolean;
    TestingWeek: number;
    HomePhone: string;
    CellPhone: string;
    InSpecialtyClass: boolean;
    Prepaid: boolean;
    Scholarship: boolean;
    ParentHelper: boolean;
    SpecialtyClasses: string;

    get StatusNote():string {
        switch (this.Status) {
            case 2: {
                return "(A)"
            }
            case 5: {
                return "(E)"
            }
            default: {
                return "(R)"
            }
        }
    }
}
