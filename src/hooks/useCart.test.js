import { it, expect } from "vitest";
import { renderHook, act } from "@testing-library/react";
import useCart from "./useCart";

it("adds items and calculates count and total", () => {
  const { result } = renderHook(() => useCart());
  act(() => result.current.addToCart({ id: 1, price: 10 }));
  act(() => result.current.addToCart({ id: 1, price: 10 }));
  expect(result.current.cartCount).toBe(2);
  expect(result.current.cartTotal).toBe(20);
});
