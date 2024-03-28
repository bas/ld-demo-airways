import { trace } from "@opentelemetry/api";

const tracer = trace.getTracer("fastCache");

const AIRPORTS = [
  {
    id: 1,
    cityName: "New York",
    airportCode: "JFK",
    country: "USA",
  },
  {
    id: 2,
    cityName: "London",
    airportCode: "LHR",
    country: "UK",
  },
  {
    id: 3,
    cityName: "Paris",
    airportCode: "CDG",
    country: "France",
  },
  {
    id: 4,
    cityName: "Tokyo",
    airportCode: "HND",
    country: "Japan",
  },
  {
    id: 5,
    cityName: "Sydney",
    airportCode: "SYD",
    country: "Australia",
  },
  {
    id: 6,
    cityName: "Dubai",
    airportCode: "DXB",
    country: "UAE",
  },
  {
    id: 7,
    cityName: "Sacramento",
    airportCode: "SMF",
    country: "USA",
  },
  {
    id: 8,
    cityName: "San Francisco",
    airportCode: "SFO",
    country: "USA",
  },
  {
    id: 9,
    cityName: "Beijing",
    airportCode: "PEK",
    country: "China",
  },
  {
    id: 10,
    cityName: "Mumbai",
    airportCode: "BOM",
    country: "India",
  },
  {
    id: 11,
    cityName: "Rio de Janeiro",
    airportCode: "GIG",
    country: "Brazil",
  },
  {
    id: 12,
    cityName: "Cape Town",
    airportCode: "CPT",
    country: "South Africa",
  },
  {
    id: 13,
    cityName: "Moscow",
    airportCode: "SVO",
    country: "Russia",
  },
  {
    id: 14,
    cityName: "Toronto",
    airportCode: "YYZ",
    country: "Canada",
  },
  {
    id: 15,
    cityName: "Los Angeles",
    airportCode: "LAX",
    country: "USA",
  },
  {
    id: 16,
    cityName: "Chicago",
    airportCode: "ORD",
    country: "USA",
  },
  {
    id: 17,
    cityName: "San Francisco",
    airportCode: "SFO",
    country: "USA",
  },
  {
    id: 18,
    cityName: "Atlanta",
    airportCode: "ATL",
    country: "USA",
  },
  {
    id: 19,
    cityName: "Dallas",
    airportCode: "DFW",
    country: "USA",
  },
  {
    id: 20,
    cityName: "Denver",
    airportCode: "DEN",
    country: "USA",
  },
  {
    id: 21,
    cityName: "Seattle",
    airportCode: "SEA",
    country: "USA",
  },
  {
    id: 22,
    cityName: "Miami",
    airportCode: "MIA",
    country: "USA",
  },
  {
    id: 23,
    cityName: "Boston",
    airportCode: "BOS",
    country: "USA",
  },
  {
    id: 24,
    cityName: "Houston",
    airportCode: "IAH",
    country: "USA",
  },
];

export const fetchAirportsFromFastCache = async () => {
  return tracer.startActiveSpan("fetchAirportsFromFastCache", async (span) => {
    const randomSleep = Math.floor(Math.random() * 120);
    await new Promise((resolve) => setTimeout(resolve, randomSleep));

    const randomError = Math.random() > 0.8;
    if (randomError) {
      throw new Error("Something went terribly wrong with the fast cache");
    }

    span.end();
    return AIRPORTS;
  });
};