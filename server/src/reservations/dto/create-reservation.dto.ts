import { IsNotEmpty } from 'class-validator';

export class CreateReservationDto {
  @IsNotEmpty()
  date: string;

  @IsNotEmpty()
  deskId: number;
}
